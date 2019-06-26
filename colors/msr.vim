" color/msr.vim to highlight marktree leaves for my monthly report.
" just change head color to dark red upon light bg marktree scheme.
" xiaolong.wang@intel.com from Jun.2019
hi clear
hi Normal    guifg=Black guibg=White ctermfg=Black ctermbg=White
hi Folded               guibg=Gray70            ctermbg=DarkBlue
hi MtFence   guifg=DarkYellow        ctermfg=DarkYellow
hi MtHead    guifg=DarkRed           ctermfg=DarkRed
hi MtHead1   guifg=DarkRed  gui=bold ctermfg=DarkRed
hi MtComment guifg=DarkCyan          ctermfg=DarkCyan
hi MtMeat    guifg=DarkGreen         ctermfg=DarkGreen
hi MtKey                 guibg=Green               ctermbg=Green
hi MtIssue            guibg=lightRed                 ctermbg=Red
hi MtSolved  guifg=Red               ctermfg=Red
hi MtTodo               guibg=Yellow              ctermbg=Yellow
hi MtDone    guifg=DarkYellow        ctermfg=DarkYellow
hi MtTag     guifg=DarkMagenta       ctermfg=DarkMagenta
hi MtLink            guibg=LightBlue ctermfg=White  ctermbg=Blue
hi MtSign    guifg=DarkYellow        ctermfg=DarkYellow
hi MtJunk    guifg=Gray              ctermfg=Gray
hi MtIndentTab          guibg=Gray90
hi MtWhiteTail        guibg=lightRed                 ctermbg=Red

