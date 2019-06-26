" color/msr.vim to highlight marktree leaves for my monthly report.
" just change head color to dark red upon light bg marktree scheme.
" xiaolong.wang@intel.com from Jun.2019
hi clear
hi Normal    guifg=Black       guibg=White ctermfg=Black       ctermbg=White
hi Folded    guifg=Black      guibg=Gray70 ctermfg=Black    ctermbg=DarkBlue
hi MtFence   guifg=DarkYellow  guibg=White ctermfg=DarkYellow  ctermbg=White
hi MtHead    guifg=DarkRed     guibg=White ctermfg=DarkRed     ctermbg=White
hi MtHead1   guifg=DarkRed     guibg=White ctermfg=DarkRed     ctermbg=White
hi MtHead1   gui=bold
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

