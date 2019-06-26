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
  hi Normal    guifg=Black       guibg=White ctermfg=Black       ctermbg=White
  hi Folded    guifg=Black      guibg=Gray70 ctermfg=Black    ctermbg=DarkBlue
  hi MtFence   guifg=DarkYellow  guibg=White ctermfg=DarkYellow  ctermbg=White
  hi MtHead    guifg=DarkMagenta guibg=White ctermfg=DarkMagenta ctermbg=White
  hi MtComment guifg=DarkCyan    guibg=White ctermfg=DarkCyan    ctermbg=White
  hi MtMeat    guifg=DarkGreen   guibg=White ctermfg=DarkGreen   ctermbg=White
  hi MtKey     guifg=Black       guibg=Green ctermfg=Black       ctermbg=Green
  hi MtIssue   guifg=Black    guibg=lightRed ctermfg=Black         ctermbg=Red
  hi MtSolved  guifg=Red         guibg=White ctermfg=Red         ctermbg=White
  hi MtTodo    guifg=Black      guibg=Yellow ctermfg=Black      ctermbg=Yellow
  hi MtDone    guifg=DarkYellow  guibg=White ctermfg=DarkYellow  ctermbg=White
  hi MtTag     guifg=DarkMagenta guibg=White ctermfg=DarkMagenta ctermbg=White
  hi MtLink    guifg=Black   guibg=LightBlue ctermfg=White        ctermbg=Blue
  hi MtSign    guifg=DarkYellow  guibg=White ctermfg=DarkYellow  ctermbg=White
  hi MtJunk    guifg=Gray        guibg=White ctermfg=Gray        ctermbg=White
  hi MtIndentTab guibg=Gray90
  hi MtWhiteTail guibg=lightRed ctermbg=Red
endif
