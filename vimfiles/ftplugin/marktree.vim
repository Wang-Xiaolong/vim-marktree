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
colorscheme marktree

" folding
setlocal foldmethod=expr
setlocal foldexpr=MtFold(v:lnum)
setlocal foldlevel=10

function! MtFold(lnum)
	let s:line = getline(a:lnum)

	let s:idx = match(s:line, '\S')
	if s:idx == -1 "empty line
		return '='
	endif	

	let s:synstack = synstack(a:lnum, 1)
	if len(s:synstack) == 0 "very plain text
		return b:T1LvlCnt + b:T2LvlCnt + MtIndentLevel(s:line)
	elseif s:synstack[0] == hlID("MtTitle0")
		return 0
	elseif s:synstack[0] == hlID("MtTitle1")
		let s:idx = match(s:line, '[^=]') / 2
		if b:T1LvlCnt < s:idx
			let b:T1LvlCnt = s:idx
		endif
		return s:idx - 1
	elseif s:synstack[0] == hlID("MtTitle2")
		let s:idx = match(s:line, '[^-]') / 2
		if b:T2LvlCnt < s:idx
			let b:T2LvlCnt = s:idx
		endif
		return b:T1LvlCnt + s:idx - 1
	elseif s:synstack[0] == hlID("MtTitleEx")
		return '='
	else "block or ordinary line
		let s:blkval = MtInBlock(a:lnum, s:line, "MtCodeBlock", "<<.*|", s:synstack[0])
		if s:blkval == 0
			let s:blkval = MtInBlock(a:lnum, s:line, "MtGhCodeBlock", "```", s:synstack[0])
		endif
		if s:blkval == 0
			let s:blkval = MtInBlock(a:lnum, s:line, "MtRefBlock", "<<:", s:synstack[0])
		endif
		if s:blkval == 0
			let s:blkval = MtInBlock(a:lnum, s:line, "MtCommentBlock", "<</[^?!]", s:synstack[0])
		endif
		if s:blkval == 2
			return '='
		elseif s:blkval == 1
			return 'a1'
		else
			return b:T1LvlCnt + b:T2LvlCnt + MtIndentLevel(s:line)
		endif
	endif
endfunction

function! MtIndentLevel(line)
	let s:n_tab_idx = match(a:line, '[^\t]')
	return s:n_tab_idx + (a:line[s:n_tab_idx] == ' ')
endfunction

function! MtFirstBlockLine(ln, line, name, start)
	let s:start_idx = match(a:line, a:start)
	if s:start_idx == -1
		return 0
	endif
	let synstart = s:synstack(a:ln, s:start_idx)
	if synstart[0] != hlID(a:name)
		return 0
	endif
	return 1
endfunction

function! MtInBlock(ln, line, name, start, synbase)
	if a:synbase == hlID(a:name)
		if MtFirstBlockLine(a:ln, a:line, a:name, a:start)
			return 0 "we don't care the 1st block line
		endif
		if MtFirstBlockLine(a:ln - 1, getline(a:ln - 1), a:name, a:start)
			return 1 "the 2nd block line
		endif
		return 2 "3rd+ lines
	endif
	return 0 "not in block
endfunction