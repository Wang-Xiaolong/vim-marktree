" color/marktree.vim to highlight marktree leaves
" xiaolong.wang@intel.com from Dec.2015

if &background == "dark" " compatible to 8bit console
  hi MtTitle gui=bold guifg=LightMagenta ctermfg=Magenta
  hi MtComment guifg=LightGreen ctermfg=Green
  hi MtMeat gui=underline guifg=White ctermfg=White
  hi MtKey gui=underline,bold guifg=Black guibg=Orange ctermfg=White ctermbg=DarkCyan
  hi MtIssue guibg=DarkRed guifg=White ctermfg=White ctermbg=DarkRed
  hi MtSolved guifg=LightRed ctermfg=Red
  hi MtTodo guibg=DarkYellow guifg=Black ctermfg=Black ctermbg=DarkYellow
  hi MtDone guifg=DarkYellow ctermfg=Yellow
  hi MtTag guifg=Magenta ctermfg=Magenta
  hi MtLink guifg=Cyan ctermfg=Cyan
  hi MtUrl gui=underline guifg=DarkCyan ctermfg=Cyan
  hi MtSign guifg=Yellow ctermfg=Yellow
  hi MtRef gui=italic guifg=LightBlue ctermfg=White
  hi MtCode guifg=LightBlue ctermfg=White
  hi MtNull guifg=Gray30 ctermfg=DarkGray
  hi MtIndentTab guibg=Gray10 ctermbg=DarkBlue
  hi MtWhiteTail guibg=Blue ctermbg=DarkRed
else " light background, console should be at least 16 color
  hi MtTitle gui=bold guifg=DarkMagenta ctermfg=DarkMagenta
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
  hi MtRef gui=italic guifg=DarkBlue ctermfg=DarkBlue
  hi MtCode guifg=Brown ctermfg=DarkBlue
  hi MtNull guifg=Grey ctermfg=LightGray
  hi MtIndentTab guibg=Grey90 ctermbg=LightGray
  hi MtWhiteTail guibg=Blue ctermbg=Blue
endif
