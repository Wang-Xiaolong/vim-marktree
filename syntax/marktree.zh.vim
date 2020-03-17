if b:MtIssueWordEn
	syn match MtIssueWordFenceZh "？" contained
	hi def link MtIssueWordFenceZh MtFence
	syn match MtIssue "\S\@<!？\k*\>" contains=MtIssueWordFenceZh
	syn match MtFix "\S\@<!？\k*\([</]/\)\@=" contains=MtIssueWordFenceZh
	syn match MtFixWordFenceZh "/？" contained
	hi def link MtFixWordFenceZh MtFence
	syn match MtFix "/？\k*\>" contains=MtFixWordFenceZh
endif
