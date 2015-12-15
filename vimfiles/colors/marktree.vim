" color/marktree.vim to highlight marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" no syntax clear or reset
let g:colors_name += " + marktree"

if &background == "dark"
  hi MtTitle gui=bold guifg=LightMagenta
  hi MtComment guifg=LightGreen
  hi MtMeat gui=underline guifg=LightCyan
  hi MtKey gui=underline,bold guifg=Orange
  hi MtIssue guibg=Red guifg=White
  hi MtSolved guifg=LightRed
  hi MtTodo guibg=Yellow guifg=Black
  hi MtDone guifg=DarkYellow
  hi MtTag guifg=Magenta
  hi MtLink guifg=Cyan
  hi MtUrl gui=underline guifg=DarkCyan
  hi MtSign guifg=Yellow
  hi MtRef gui=italic guifg=LightBlue
  hi MtCode guifg=LightYellow
  hi MtNull guifg=Grey30
  hi MtIndentTab guibg=Grey10
  hi MtWhiteTail guibg=Blue
else
  hi MtTitle gui=bold guifg=DarkMagenta
  hi MtComment guifg=DarkGreen
  hi MtMeat gui=underline
  hi MtKey gui=underline,bold guifg=Orange
  hi MtIssue guibg=Red guifg=White
  hi MtSolved guifg=Red
  hi MtTodo guibg=Yellow guifg=Black
  hi MtDone guifg=DarkYellow
  hi MtTag guifg=Magenta
  hi MtLink guifg=Blue
  hi MtUrl gui=underline guifg=DarkCyan
  hi MtSign guifg=DarkYellow
  hi MtRef gui=italic guifg=DarkBlue
  hi MtCode guifg=Brown
  hi MtNull guifg=Grey
  hi MtIndentTab guibg=Grey90
  hi MtWhiteTail guibg=Blue
endif
