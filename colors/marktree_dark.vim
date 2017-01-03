" Vim color file
" Maintainer: Paulo Wang <xiaolong.wang@intel.com>
" Last Change: 2016/2/20
" grey on black, modified from 'torte', for marktree editing

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "marktree_dark"

" Basic elements
hi Normal     guifg=Grey  guibg=Black           ctermfg=Grey  ctermbg=Black
hi Search     guifg=Black guibg=Red    gui=bold ctermfg=Black ctermbg=Red   cterm=NONE 
hi Visual     guifg=DarkGrey           gui=bold                             cterm=reverse
hi Cursor     guifg=Black guibg=Green  gui=bold ctermfg=Black ctermbg=Green cterm=bold
hi Special    guifg=Orange                      ctermfg=Brown
hi Comment    guifg=DarkCyan                    ctermfg=DarkCyan
hi StatusLine guifg=Blue  guibg=White           ctermfg=Blue  ctermbg=White 
hi Statement  guifg=Yellow             gui=NONE ctermfg=Yellow              cterm=NONE
hi Type                                gui=NONE                             cterm=NONE

" Additional elements
hi Folded     guifg=Black guibg=DarkGrey        ctermfg=Black ctermbg=DarkBlue

" Marktree elements
hi MtTitle    guifg=LightMagenta       gui=bold ctermfg=Magenta
hi MtComment  guifg=LightGreen                  ctermfg=Green
hi MtMeat     guifg=White         gui=underline ctermfg=White
hi MtKey      guifg=Black guibg=Orange gui=bold ctermfg=White ctermbg=DarkCyan
hi MtIssue    guifg=White guibg=DarkRed         ctermfg=White ctermbg=DarkRed
hi MtSolved   guifg=LightRed                    ctermfg=Red
hi MtTodo     guifg=Black guibg=DarkYellow      ctermfg=Black ctermbg=DarkYellow
hi MtDone     guifg=DarkYellow                  ctermfg=DarkYellow
hi MtTag      guifg=Magenta                     ctermfg=Magenta
hi MtLink     guifg=Cyan                        ctermfg=Cyan
hi MtUrl      guifg=DarkCyan      gui=underline ctermfg=DarkCyan
hi MtSign     guifg=Yellow                      ctermfg=Yellow
hi MtRef      guifg=LightBlue        gui=italic
hi MtCode     guifg=LightBlue
hi MtNull     guifg=Gray30                      ctermfg=DarkGray
hi MtIndentTab            guibg=Gray10
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
