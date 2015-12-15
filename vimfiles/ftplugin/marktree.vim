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
let b:Title1LevelCnt = 0
let b:Title2LevelCnt = 0

function! MtFold(lnum)
	let line = getline(a:lnum)

	let idx = match(line, '\S')
	if idx == -1 "empty line
		return '='
	endif	

	let synstack = synstack(a:lnum, 1)
	if len(synstack) == 0 "very plain text
		return b:Title1LevelCnt + b:Title2LevelCnt + MtIndentLevel(line)
	elseif synstack[0] == hlID("MtTitle0")
		return 0
	elseif synstack[0] == hlID("MtTitle1")
		let idx = match(line, '[^=]') / 2
		if b:Title1LevelCnt < idx
			let b:Title1LevelCnt = idx
		endif
		return idx - 1
	elseif synstack[0] == hlID("MtTitle2")
		let idx = match(line, '[^-]') / 2
		if b:Title2LevelCnt < idx
			let b:Title2LevelCnt = idx
		endif
		return b:Title1LevelCnt + idx - 1
	else "block or ordinary line
		let blkval = MtInBlock(a:lnum, line, "MtCodeBlock", "<<.*{", synstack[0])
		if blkval == 0
			let blkval = MtInBlock(a:lnum, line, "MtRefBlock", "<<:", synstack[0])
		endif
		if blkval == 0
			let blkval = MtInBlock(a:lnum, line, "MtCommentBlock", "<</[^?!]", synstack[0])
		endif
		if blkval == 2
			return '='
		elseif blkval == 1
			return 'a1'
		else
			return b:Title1LevelCnt + b:Title2LevelCnt + MtIndentLevel(line)
		endif
	endif
endfunction

function! MtIndentLevel(line)
	let n_tab_idx = match(a:line, '[^\t]')
	return n_tab_idx + (a:line[n_tab_idx] == ' ')
endfunction

function! MtFirstBlockLine(ln, line, name, start)
	let start_idx = match(a:line, a:start)
	if start_idx == -1
		return 0
	endif
	let synstart = synstack(a:ln, start_idx)
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