if b:MtIssueWordEn
	syn match MtIssueWordFenceZh "？" contained
	hi def link MtIssueWordFenceZh MtFence
	syn match MtIssue "\S\@<!？\k*\>" contains=MtIssueWordFenceZh
	syn match MtFix "\S\@<!？\k*\([</]/\)\@=" contains=MtIssueWordFenceZh
	syn match MtFixWordFenceZh "/？" contained
	hi def link MtFixWordFenceZh MtFence
	syn match MtFix "/？\k*\>" contains=MtFixWordFenceZh
endif

syn region MtIssueLine matchgroup=MtFence start="\S\@<!？\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtFixLine matchgroup=MtFence start="\S\@<!/？\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtFixLine matchgroup=MtFence start="\S\@<!/\=？\s\+"
  \ end="\([</]/\)\@=" contains=MtKey oneline

