autocmd BufNewFile,BufRead *.mt,*.mkt,*.marktree setfiletype marktree
autocmd BufNewFile,BufRead *.txt,*.log
  \ let firstline = getline(1)
  \|if firstline =~# '^\[MT\].*'
  \|  set filetype=marktree
  \|endif
" =~ is string match, # is match case (? is ignore case)