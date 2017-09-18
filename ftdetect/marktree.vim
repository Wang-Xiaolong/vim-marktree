autocmd BufNewFile,BufRead *.marktree setfiletype marktree
autocmd BufNewFile,BufRead *.txt,*.log,*.mt
  \ let s:firstline = getline(1)
  \|if s:firstline =~# '<mt\S*>'
  \|  set filetype=marktree
  \|endif
