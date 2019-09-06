" color/marktree.vim to highlight marktree leaves
" xiaolong.wang@intel.com from Dec.2015
hi clear
if &background == "dark" " compatible to 8bit console, assume Gray on Black
  hi Normal    guifg=Gray       guibg=Black ctermfg=Gray       ctermbg=Black
  hi Folded    guifg=Black     guibg=Gray40 ctermfg=Black   ctermbg=DarkBlue
  hi MtFence   guifg=DarkYellow             ctermfg=DarkYellow
  hi MtHead    guifg=Magenta                ctermfg=Magenta
  hi MtHead1   guifg=Magenta       gui=bold ctermfg=Magenta
  hi MtComment guifg=Cyan                   ctermfg=Cyan
  hi MtMeat    guifg=Green                  ctermfg=Green
  hi MtKey     guifg=White  guibg=DarkGreen ctermfg=White  ctermbg=DarkGreen
  hi MtIssue   guifg=White    guibg=DarkRed ctermfg=White    ctermbg=DarkRed
  hi MtFix     guifg=Red                    ctermfg=Red
  hi MtTodo    guifg=White guibg=DarkYellow ctermfg=White ctermbg=DarkYellow
  hi MtDone    guifg=Yellow                 ctermfg=Yellow
  hi MtTag     guifg=Magenta                ctermfg=Magenta
  hi MtLink    guifg=White   guibg=DarkBlue ctermfg=White   ctermbg=DarkBlue
  hi MtSign    guifg=Yellow                 ctermfg=Yellow
  hi MtFade    guifg=DarkGray               ctermfg=DarkGray
  hi MtIndentTab               guibg=Gray10
  hi MtWhiteTail              guibg=DarkRed                  ctermbg=DarkRed
else " light background, console should >=16 color, assume Black on White
  hi Normal    guifg=Black    guibg=White ctermfg=Black ctermbg=White
  hi Folded    guifg=Black     guibg=Gray ctermfg=Black  ctermbg=Gray
  hi MtFence   guifg=DarkYellow           ctermfg=DarkYellow
  hi MtHead    guifg=DarkMagenta          ctermfg=DarkMagenta
  hi MtHead1   guifg=DarkMagenta gui=bold ctermfg=DarkMagenta
  hi MtComment guifg=DarkCyan             ctermfg=DarkCyan
  hi MtMeat    guifg=DarkGreen            ctermfg=DarkGreen
  hi MtKey                    guibg=Green               ctermbg=Green
  hi MtIssue               guibg=lightRed                 ctermbg=Red
  hi MtFix     guifg=Red                  ctermfg=Red
  hi MtTodo                  guibg=Yellow              ctermbg=Yellow
  hi MtDone    guifg=DarkYellow           ctermfg=DarkYellow
  hi MtTag     guifg=DarkMagenta          ctermfg=DarkMagenta
  hi MtLink               guibg=LightBlue ctermfg=White  ctermbg=Blue
  hi MtSign    guifg=DarkYellow           ctermfg=DarkYellow
  hi MtFade    guifg=Gray                 ctermfg=Gray
  hi MtIndentTab             guibg=Gray90
  hi MtWhiteTail           guibg=lightRed                 ctermbg=Red
endif
