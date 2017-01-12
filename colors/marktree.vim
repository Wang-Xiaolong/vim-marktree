" color/marktree.vim to highlight marktree leaves
" xiaolong.wang@intel.com from Dec.2015

if &background == "dark" " compatible to 8bit console, assume Grey on Black
  hi MtHead gui=bold guifg=LightMagenta ctermfg=Magenta
  hi MtComment guifg=LightBlue ctermfg=Blue
  hi MtMeat gui=underline guifg=White ctermfg=White
  hi MtKey gui=underline,bold guibg=DarkMagenta guifg=White
\      ctermbg=DarkMagenta ctermfg=White
  hi MtIssue guibg=DarkRed guifg=White ctermbg=DarkRed ctermfg=White
  hi MtSolved guifg=LightRed ctermfg=Red
  hi MtTodo guibg=DarkYellow guifg=Black ctermbg=DarkYellow ctermfg=Black
  hi MtDone guifg=DarkYellow ctermfg=Yellow
  hi MtTag guifg=Magenta ctermfg=Magenta
  hi MtLink guifg=Cyan ctermfg=Cyan
  hi MtUrl gui=underline guifg=DarkCyan ctermfg=Cyan
  hi MtSign guifg=Yellow ctermfg=Yellow
  hi MtQuote gui=italic guifg=Green ctermfg=Green
  hi MtCode guifg=Cyan ctermfg=Cyan
  hi MtNull guifg=DarkGray ctermfg=DarkGray
  hi MtIndentTab guibg=Gray10
  hi MtWhiteTail guibg=Blue ctermbg=DarkRed
else " light background, console should >=16 color, assume Black on White
  hi MtHead gui=bold guifg=DarkMagenta ctermfg=DarkMagenta
  hi MtComment guifg=DarkGreen ctermfg=DarkGreen
  hi MtMeat gui=underline ctermfg=DarkCyan
  hi MtKey gui=underline,bold guifg=Orange ctermbg=Cyan
  hi MtIssue guibg=Red guifg=White ctermfg=White ctermbg=Red
  hi MtSolved guifg=Red ctermfg=DarkRed
  hi MtTodo guibg=Yellow guifg=Black ctermbg=Yellow
  hi MtDone guifg=DarkYellow ctermfg=DarkYellow
  hi MtTag guifg=Magenta ctermfg=DarkMagenta
  hi MtLink guifg=Blue ctermfg=Blue
  hi MtUrl gui=underline guifg=DarkCyan ctermfg=Blue
  hi MtSign guifg=DarkYellow ctermfg=DarkYellow
  hi MtQuote gui=italic guifg=DarkBlue ctermfg=DarkBlue
  hi MtCode guifg=Brown ctermfg=DarkBlue
  hi MtNull guifg=Gray ctermfg=LightGray
  hi MtIndentTab guibg=Gray90
  hi MtWhiteTail guibg=Blue ctermbg=Blue
endif
