autocmd BufNewFile,BufRead *.mt,*.mkt,*.marktree setfiletype marktree
autocmd BufNewFile,BufRead *.txt,*.log
  \ let firstline = getline(1)
  \|if firstline =~# '^<mt\S*>.*'
  \|  set filetype=marktree
  \|endif
