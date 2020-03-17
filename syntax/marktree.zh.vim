if b:MtIssueWordEn
	syn match MtIssueWordFenceZh "？" contained
	hi def link MtIssueWordFenceZh MtFence
	syn match MtIssue "\S\@<!？\k*\>" contains=MtIssueWordFenceZh
	syn match MtFix "\S\@<!？\k*\([</]/\)\@=" contains=MtIssueWordFenceZh
	syn match MtFixWordFenceZh "/？" contained
	hi def link MtFixWordFenceZh MtFence
	syn match MtFix "/？\k*\>" contains=MtFixWordFenceZh
endif
if b:MtTodoWordEn
	syn match MtTodoWordFenceZh "！" contained
	hi def link MtTodoWordFenceZh MtFence
	syn match MtTodo "\S\@<!！\k*\>" contains=MtTodoWordFenceZh
	syn match MtDone "\S\@<!！\k*\([</]/\)\@=" contains=MtTodoWordFenceZh
	syn match MtDoneWordFenceZh "/！" contained
	hi def link MtDoneWordFenceZh MtFence
	syn match MtDone "/！\k*\>" contains=MtDoneWordFenceZh
endif

syn region MtIssueLine matchgroup=MtFence start="\S\@<!？\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtFixLine matchgroup=MtFence start="\S\@<!/？\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtFixLine matchgroup=MtFence start="\S\@<!/\=？\s\+"
  \ end="\([</]/\)\@=" contains=MtKey oneline
syn region MtTodoLine matchgroup=MtFence start="\S\@<!！\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtDoneLine matchgroup=MtFence start="\S\@<!/！\s\+" end="$"
  \ contains=WtWhiteTail,MtKey oneline keepend
syn region MtDoneLine matchgroup=MtFence start="\S\@<!/\=！\s\+"
  \ end="\([</]/\)\@=" contains=MtKey oneline

