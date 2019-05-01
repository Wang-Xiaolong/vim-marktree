" ftplugin/marktree.vim
" xiaolong.wang@intel.com from Dec.2015

" indent, tab and color
setlocal autoindent
setlocal copyindent
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=0
setlocal noexpandtab
setlocal nosmarttab
setlocal textwidth=0
colorscheme marktree

" folding
setlocal foldmethod=expr
setlocal foldexpr=MtFold(v:lnum)
setlocal foldlevel=10

" init: get options from the 1st line and parse
let b:MtPath = expand('<sfile>:p:h:h')
let s:opt = matchstr(getline(1), '<mt\S*>')
if s:opt == ""
	let b:H1Levels = 0
	let b:H2Levels = 0
	let b:MtKeyWordEn = 1
	let b:MtIssueWordEn = 1
	let b:MtTodoWordEn = 1
	exit
endif

let b:MtExtList = []
let s:idx = 1
while 1
	let s:ext = matchstr(s:opt, '+\zs\w\+', 0, s:idx)
	if s:ext == ""
		break
	endif
	let s:extpath = b:MtPath . '/syntax/marktree.ext/' . s:ext . '.vim'
	if filereadable(s:extpath)
		execute 'source '.s:extpath
		call add(b:MtExtList, s:ext)
	else
		echo "File not found: " . s:extpath
	endif
	let s:idx += 1
endwhile

let s:opt = substitute(s:opt, '+\w\+', '', 'g')
let b:H1Levels = strlen(substitute(s:opt, "[^=]", "", "g"))
let b:H2Levels = strlen(substitute(s:opt, "[^-]", "", "g"))
if s:opt =~ '\^'
	let b:MtKeyWordEn = (s:opt !~ '*')
	let b:MtIssueWordEn = (s:opt !~ '?')
	let b:MtTodoWordEn = (s:opt !~ '!')
else
	let b:MtKeyWordEn = (s:opt =~ '*')
	let b:MtIssueWordEn = (s:opt =~ '?')
	let b:MtTodoWordEn = (s:opt =~ '!')
endif
" End of init

function! MtFold(lnum)
	let s:line = getline(a:lnum)
	if match(s:line, '\S') == -1 "Blank line
		return '='
	endif	

	let s:synstack = synstack(a:lnum, 1)
	if len(s:synstack) == 0 "Normal
		return b:H1Levels + b:H2Levels + MtIndentLevel(s:line)
	endif
	let s:synroot = synIDattr(s:synstack[0], "name")
	if s:synroot == "MtHead0"
		return 0
	elseif s:synroot == "MtHead1"
		if s:line !~ '^==\+\s\+.\+$' "Not the 1st line
			return '='
		endif "Then, the 1st line
		let s:idx = match(s:line, '[^=]') / 2 "Count of == -> level
		if b:H1Levels < s:idx
			let b:H1Levels = s:idx
		endif
		return b:H1Levels - s:idx
	elseif s:synroot == "MtHead2"
		if s:line !~ '^--\+\s\+.\+$' "Not the 1st line
			return '='
		endif "Then, the 1st line
		let s:idx = match(s:line, '[^-]') / 2 "Count of -- -> level
		if b:H2Levels < s:idx
			let b:H2Levels = s:idx
		endif
		return b:H1Levels + s:idx - 1
	elseif s:synroot =~ 'Mt\w\+Block$' || s:synroot == "MtBlockFence"
		return '='
	else
		return b:H1Levels + b:H2Levels + MtIndentLevel(s:line)
	endif
endfunction

function! MtIndentLevel(line)
	let s:n_tab_idx = match(a:line, '[^\t]')
	return s:n_tab_idx + (a:line[s:n_tab_idx] == ' ')
endfunction

command! MTI :call MtSearchIssue()
function! MtSearchIssue()
	vimgrep "[<?/]\@<!?\k\+\>\([</]/\)\@!\|[?</]\@<!???\@!\(.*[</]/\)\@!\|[<=]\@<!<??\@!\|<??" %
endfunction

command! MTT :call MtSearchTodo()
function! MtSearchTodo()
	vimgrep "[<!/]\@<!!\k\+\>\([</]/\)\@!\|[!</]\@<!!!!\@!\(.*[</]/\)\@!\|[<=]\@<!<!!\@!\|<!!" %
endfunction
