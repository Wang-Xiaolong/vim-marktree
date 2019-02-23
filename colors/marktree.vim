" color/marktree.vim to highlight marktree leaves
" xiaolong.wang@intel.com from Dec.2015

if &background == "dark" " compatible to 8bit console, assume Grey on Black
  hi Normal guifg=Gray guibg=Black ctermfg=Gray ctermbg=Black
  hi MtFence guifg=DarkYellow ctermfg=DarkYellow
  hi MtBlockFence guifg=Yellow ctermfg=Yellow 
  hi MtHead gui=bold guifg=Magenta ctermfg=Magenta
  hi MtComment guifg=Cyan ctermfg=Cyan
  hi MtMeat gui=underline guifg=Green ctermfg=Green
  hi MtKey gui=underline,bold guibg=DarkGreen guifg=White
\      ctermbg=DarkGreen ctermfg=Black
  hi MtIssue guibg=DarkRed guifg=White ctermbg=DarkRed ctermfg=White
  hi MtSolved guifg=Red ctermfg=Red
  hi MtTodo guibg=DarkYellow guifg=Black ctermbg=DarkYellow ctermfg=Black
  hi MtDone guifg=Yellow ctermfg=Yellow
  hi MtTag guifg=Magenta ctermfg=Magenta
  hi MtLink guifg=White guibg=DarkBlue ctermfg=Blue
  hi MtUrl gui=underline guifg=DarkCyan ctermfg=Blue
  hi MtSign guifg=Yellow ctermfg=Yellow
  hi MtJunk guifg=DarkGray ctermfg=DarkGray
  hi MtIndentTab guibg=Gray10
  hi MtWhiteTail guibg=DarkRed ctermbg=DarkRed
else " light background, console should >=16 color, assume Black on White
  hi Normal guifg=DarkGray guibg=White ctermfg=DarkGray ctermbg=White
  hi MtHead gui=bold guifg=DarkMagenta ctermfg=DarkMagenta
  hi MtKey gui=underline,bold guifg=Orange ctermbg=Cyan
  hi MtIssue guibg=Red guifg=White ctermfg=White ctermbg=Red
  hi MtSolved guifg=Red ctermfg=DarkRed
  hi MtTodo guibg=Yellow guifg=Black ctermbg=Yellow
  hi MtDone guifg=DarkYellow ctermfg=DarkYellow
  hi MtTag guifg=Magenta ctermfg=DarkMagenta
  hi MtLink guifg=Blue ctermfg=Blue
  hi MtUrl gui=underline guifg=DarkCyan ctermfg=Blue
  hi MtSign guifg=DarkYellow ctermfg=DarkYellow
  hi MtJunk guifg=Gray ctermfg=LightGray
  hi MtIndentTab guibg=Gray90
  hi MtWhiteTail guibg=Blue ctermbg=Blue
endif
