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
	let b:MtTagWordEn = 1
	let b:MtLinkWordEn = 1
	exit
endif

let b:MtExtList = []
let s:idx = 1
while 1
	let s:ext = matchstr(s:opt, '+\zs\w\+', 0, s:idx)
	if s:ext == ""
		break
	endif
	let s:extpath = b:MtPath.'/syntax/marktree.'.s:ext.'.vim'
	if filereadable(s:extpath)
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
	let b:MtTagWordEn = (s:opt !~ '#')
	let b:MtLinkWordEn = (s:opt !~ '[~]')
else
	let b:MtKeyWordEn = (s:opt =~ '*')
	let b:MtIssueWordEn = (s:opt =~ '?')
	let b:MtTodoWordEn = (s:opt =~ '!')
	let b:MtTagWordEn = (s:opt =~ '#')
	let b:MtLinkWordEn = (s:opt =~ '[~]')
endif
" End of init

function! MtFold(lnum)
	let l:line = getline(a:lnum)
	if match(l:line, '\S') == -1 "Blank line
		return '='
	endif	

	let l:synstack = synstack(a:lnum, 1)
	if len(l:synstack) == 0 "Normal
		return b:H1Levels + b:H2Levels + match(l:line, '[^\t]')
	endif
	let l:synroot = synIDattr(l:synstack[0], "name")
	if l:synroot == "MtHead0"
		return 0
	elseif l:synroot =~ "^MtHead1"
		if len(l:synstack) == 2 && synIDattr(l:synstack[1], "name") == "MtFence" "1st line
			if l:synroot == "MtHead1Hi"
				let l:line = strpart(l:line, 1) "trim *
			endif
			let l:idx = match(l:line, '[^=]') / 2 "Count of ==
			if l:idx < 1 "odd corner case
				return '='
			endif
			if b:H1Levels < l:idx
				let b:H1Levels = l:idx
			endif
			return b:H1Levels - l:idx
		endif
		return '='
	elseif l:synroot =~ "^MtHead2"
		if len(l:synstack) == 2 && synIDattr(l:synstack[1], "name") == "MtFence" "1st line
			if l:synroot == "MtHead2Hi"
				let l:line = strpart(l:line, 1) "trim *
			endif
			let l:idx = match(l:line, '[^-]') / 2 "Count of --
			if l:idx < 1 "odd corner case
				return '='
			endif
			if b:H2Levels < l:idx
				let b:H2Levels = l:idx
			endif
			return b:H1Levels + l:idx - 1
		endif
		return '='
	elseif l:synroot =~ 'Mt\w\+Block$' || l:synroot == "MtBlockFence" || l:synroot == "MtFence"
		return '='
	else
		return b:H1Levels + b:H2Levels + match(l:line, '[^\t]')
	endif
endfunction

command! MTI :call MtSearchIssue()
function! MtSearchIssue()
	vimgrep "[<?/]\@<!?\k\+\>\([</]/\)\@!\|\S\@<!?\s\(.*[</]/\)\@!\|[<=]\@<!<??\@!\|<?\s" %
endfunction

command! MTT :call MtSearchTodo()
function! MtSearchTodo()
	vimgrep "[<!/]\@<!!\k\+\>\([</]/\)\@!\|\S\@<!!\s\(.*[</]/\)\@!\|[<=]\@<!<!!\@!\|<!\s" %
endfunction
