" Vim color file
" Maintainer: Paulo Wang <xiaolong.wang@intel.com>
" Last Change: 2016/2/20
" black on white, modified from 'torte', for marktree export

set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "marktree_light"

" Basic elements
hi Normal     guifg=Black guibg=White           ctermfg=Black ctermbg=White
hi Special    guifg=Orange                      ctermfg=Brown
hi Comment    guifg=Blue                        ctermfg=Blue
hi Statement  guifg=DarkYellow         gui=NONE ctermfg=DarkYellow          cterm=NONE
hi Type                                gui=NONE                             cterm=NONE

" Marktree elements
hi MtTitle    guifg=DarkMagenta        gui=bold ctermfg=DarkMagenta
hi MtComment  guifg=DarkGreen                   ctermfg=DarkGreen
hi MtMeat     guifg=Blue          gui=underline ctermfg=Blue
hi MtKey      guifg=Black guibg=Orange gui=bold ctermfg=Black ctermbg=Cyan
hi MtIssue    guifg=White guibg=Red             ctermfg=White ctermbg=Red
hi MtSolved   guifg=DarkRed                     ctermfg=DarkRed
hi MtTodo     guifg=Black guibg=DarkYellow      ctermfg=Black ctermbg=DarkYellow
hi MtDone     guifg=DarkYellow                  ctermfg=DarkYellow
hi MtTag      guifg=Magenta                     ctermfg=Magenta
hi MtLink     guifg=DarkCyan                    ctermfg=DarkCyan
hi MtUrl      guifg=DarkCyan      gui=underline ctermfg=DarkCyan
hi MtSign     guifg=DarkYellow                  ctermfg=DarkYellow
hi MtRef      guifg=DarkBlue         gui=italic ctermfg=DarkBlue
hi MtCode     guifg=DarkBlue                    ctermfg=DarkBlue
hi MtNull     guifg=lightGrey                   ctermfg=LightGrey
hi MtIndentTab                         gui=NONE                             cterm=NONE
hi MtWhiteTail            guibg=DarkRed                       ctermbg=DarkRed

" Extension files
if exists("b:MtExtList")
	for s:filestr in b:MtExtList
		let s:filestrfull = g:mtpath . '/colors/marktree_extension/' . s:filestr . '.vim'
		if filereadable(s:filestrfull)
			execute 'source '.s:filestrfull
		endif
	endfor
endif
