" color/marktree.vim to highlight marktree leaves
" xiaolong.wang@intel.com from Dec.2015

if &background == "dark" " compatible to 8bit console, assume Grey on Black
  hi Normal    guifg=Gray       guibg=Black ctermfg=Gray       ctermbg=Black
  hi Folded    guifg=Black     guibg=Gray40 ctermfg=Black   ctermbg=DarkBlue
  hi MtFence   guifg=DarkYellow guibg=Black ctermfg=DarkYellow ctermbg=Black
  hi MtHead    guifg=Magenta    guibg=Black ctermfg=Magenta    ctermbg=Black
  hi MtComment guifg=Cyan       guibg=Black ctermfg=Cyan       ctermbg=Black
  hi MtMeat    guifg=Green      guibg=Black ctermfg=Green      ctermbg=Black
  hi MtKey     guifg=White  guibg=DarkGreen ctermfg=White  ctermbg=DarkGreen
  hi MtIssue   guifg=White    guibg=DarkRed ctermfg=White    ctermbg=DarkRed
  hi MtSolved  guifg=Red        guibg=Black ctermfg=Red        ctermbg=Black
  hi MtTodo    guifg=White guibg=DarkYellow ctermfg=White ctermbg=DarkYellow
  hi MtDone    guifg=Yellow     guibg=Black ctermfg=Yellow     ctermbg=Black
  hi MtTag     guifg=Magenta    guibg=Black ctermfg=Magenta    ctermbg=Black
  hi MtLink    guifg=White   guibg=DarkBlue ctermfg=White   ctermbg=DarkBlue
  hi MtSign    guifg=Yellow     guibg=Black ctermfg=Yellow     ctermbg=Black
  hi MtJunk    guifg=DarkGray   guibg=Black ctermfg=DarkGray   ctermbg=Black
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
