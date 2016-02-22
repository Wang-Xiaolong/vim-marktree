autocmd BufNewFile,BufRead *.mt,*.mkt,*.marktree setfiletype marktree
autocmd BufNewFile,BufRead *.txt,*.log
  \ let s:firstline = getline(1)
  \|if s:firstline =~# '<mt\S*>'
  \|  set filetype=marktree
  \|endif
