" syn/marktree.vim to define marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" sync from start to correctly hi long blocks
syn sync fromstart
syn sync maxlines=500

" == Clusters ==
syn cluster MtKeys contains=MtKey
syn cluster MtMeats contains=MtMeat,MtMeatSt
syn cluster MtLinks contains=MtLink,MtLinkSt,@MtAutoLink
syn cluster MtGeneralMark contains=@MtKeys,MtTag,MtIssue,MtSolved,MtSolvedC,MtTodo,MtDone,MtIssueSt,MtSolvedSt,MtTodoSt,MtDoneSt
syn cluster MtCommentMark contains=@MtGeneralMark,@MtMeats,@MtLinks
syn cluster MtMeatMark contains=@MtGeneralMark,MtComment,MtCommentLine
syn cluster MtQuoteMark contains=@MtGeneralMark,MtComment,MtCommentLine,@MtMeats,@MtLinks,MtNull,MtNullSt
syn cluster MtHeadMark contains=@MtGeneralMark,@MtLinks,MtComment,MtCommentLine,MtCommentBlock,@MtLinet
syn cluster MtCommentBlockLine contains=MtMeatLine,MtIssueLine,MtSolvedLine,MtSolvedCLine,MtTodoLine,MtDoneLine,MtLinkLine
syn cluster MtQuoteBlockLine contains=MtCommentLine,MtMeatLine,MtIssueLine,MtSolvedLine,MtSolvedCLine,MtTodoLine,MtDoneLine,MtLinkLine,MtNullLine
syn cluster MtCodeBlockLine contains=MtCodeComment,MtCodeIssue,MtCodeSolved,MtCodeSolvedC,MtCodeTodo,MtCodeDone,MtCodeDoneC
" init
function! MtSyntaxInit()
	let s:optstr = matchstr(getline(1), '<mt\S*>')
	let b:MtExtList = []
	let b:MtKeyWEn = 0
	let b:MtIssueWEn = 0
	let b:MtTodoWEn = 0
	let b:MtTagWEn = 0
	let b:MtLinkWEn = 0
	let b:MtQuoteDoubleEn = 0
	let b:MtCodeSingleEn = 0
	if s:optstr == ""
		let b:T1LvlCnt = 0
		let b:T2LvlCnt = 0
		return
	endif
	let s:idx = 1
	while 1
		let s:filestr = matchstr(s:optstr, '+\zs\w\+', 0, s:idx)
		if s:filestr == ""
			break
		endif
		let s:filestrfull = g:mtpath . '/syntax/marktree.ext/' . s:filestr . '.vim'
		if filereadable(s:filestrfull)
			execute 'source '.s:filestrfull
			call add(b:MtExtList, s:filestr)
		else
			echo "File not found: " . s:filestrfull
		endif
		let s:idx = s:idx + 1
	endwhile
	let s:optstr = substitute(s:optstr, '+\w\+', '', 'g')
	let b:T1LvlCnt = strlen(substitute(s:optstr, "[^=]", "", "g"))
	let b:T2LvlCnt = strlen(substitute(s:optstr, "[^-]", "", "g"))
	if s:optstr =~ '\^'
		let b:MtKeyWEn = (s:optstr !~ '*')
		let b:MtIssueWEn = (s:optstr !~ '?')
		let b:MtTodoWEn = (s:optstr !~ '!')
		let b:MtTagWEn = (s:optstr !~ '#')
		let b:MtLinkWEn = (s:optstr !~ '[~]')
		let b:MtQuoteSingleEn = (s:optstr !~ "'")
		let b:MtQuoteDoubleEn = (s:optstr !~ '"')
		let b:MtCodeSingleEn = (s:optstr !~ '`')
	else
		let b:MtKeyWEn = (s:optstr =~ '*')
		let b:MtIssueWEn = (s:optstr =~ '?')
		let b:MtTodoWEn = (s:optstr =~ '!')
		let b:MtTagWEn = (s:optstr =~ '#')
		let b:MtLinkWEn = (s:optstr =~ '[~]')
		let b:MtQuoteSingleEn = (s:optstr =~ "'")
		let b:MtQuoteDoubleEn = (s:optstr =~ '"')
		let b:MtCodeSingleEn = (s:optstr =~ '`')
	endif
endfunction

let g:mtpath = expand('<sfile>:p:h:h')
call MtSyntaxInit()

" == Small Stuff ==
" It is here before the Lines and Regions because if not so,
" Lines and Regions may can't be recognized.
" Seems for VIM, code at the back make effects.
syn match MtIndent "^\s\+" contains=MtIndentTab,MtTabAfterSpace
syn match MtIndentTab "^\t\+" contained
syn match MtWhiteTail "\s\+$"
syn match MtTabAfterSpace " \+\t\+" contained
syn match MtSign "^\t*[\*+\-] \(\[.\?\]\)\?" contains=MtIndent,MtSignIssue,MtSignTodo
syn match MtNumSign "^\t*\d\+\. \(\[.\?\]\)\?" contains=MtIndent,MtSignIssue,MtSignTodo
syn match MtLetterSign "^\t*[a-zA-Z]\. \(\[.\?\]\)\?" contains=MtIndent,MtSignIssue,MtSignTodo
syn match MtSignTodo "\[ \?\]" contained
syn match MtSignIssue "\[?\]" contained
syn match MtSeparator "^\s*-\{6,}\s*$\|^\s\+\*\s\+\*\s\+\*\s*$" contains=@MtLinet
syn match MtUrl "[a-z]\{3,6}:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*"
syn match MtEmail "[a-z0-9_\.-]\+@[0-9a-z\.-]\+\.[a-z\.]\{2,6}"
syn match MtOption "<mt\S*>" contained

syn cluster MtLinet contains=MtIndent,MtWhiteTail
syn cluster MtAutoLink contains=MtUrl,MtEmail

hi default link MtTabAfterSpace MtWhiteTail
hi default link MtNumSign MtSign
hi default link MtLetterSign MtSign
hi default link MtSeparator MtSign
hi default link MtEmail MtUrl
hi default link MtSignTodo MtTodo
hi default link MtSignIssue MtIssue
hi default link MtOption MtSign

" == Titles ==
syn region MtHead0 start="\%^" end="^\s*$" contains=@MtHeadMark,MtOption
syn region MtHead1 start="^==\+\s" end="\s==\+$" contains=@MtHeadMark
syn region MtHead2 start="^--\+\s" end="\s--\+$" contains=@MtHeadMark
syn match MtHead "^\t*#[^#].*#$" contains=@MtHeadMark

hi default link MtHead0 MtHead
hi default link MtHead1 MtHead
hi default link MtHead2 MtHead

" == Marks ==
" -- Word Marks --
" Very light marks that mark only 1 word. All optional:
if b:MtKeyWEn
	syn match MtKeyW "\*[^ \t=.*/]\S\{-}\>"
	hi default link MtKeyW MtKey
	syn cluster MtKeys add=MtKeyW
endif
if b:MtIssueWEn
	syn match MtIssueW "?\S\{-}\>"
	syn match MtSolvedW "/?\S\{-}\>"
	syn match MtSolvedWC "/\=?\S\{-}\(//\S\{-}\)\+\>" contains=MtCommentInWC
	syn match MtCommentInWC "\(//\S\{-}\)\+\>" contained
	hi default link MtIssueW MtIssue
	hi default link MtSolvedW MtSolved
	hi default link MtSolvedWC MtSolved
	hi default link MtCommentInWC MtComment
	syn cluster MtGeneralMark add=MtIssueW,MtSolvedW,MtSolvedWC
endif
if b:MtTodoWEn
	syn match MtTodoW "![^ \t=]\S\{-}\>"
	syn match MtDoneW "/![^ \t=]\S\{-}\>"
	syn match MtDoneWC "/\=![^ \t=]\S\{-}\(//\S\{-}\)\+\>" contains=MtCommentInWC
	hi default link MtTodoW MtTodo
	hi default link MtDoneW MtDone
	hi default link MtDoneWC MtDone
	syn cluster MtGeneralMark add=MtTodoW,MtDoneW,MtDoneWC
endif
if b:MtTagWEn
	syn match MtTagW "#[^ \t0-9]\S*\>"
	hi default link MtTagW MtTag
	syn cluster MtGeneralMark add=MtTagW
endif
if b:MtLinkWEn
	syn match MtLinkW "[~][^ \t0-9>~/]\S*\>"
	hi default link MtLinkW MtLink
	syn cluster MtLinks add=MtLinkW
endif
if b:MtQuoteSingleEn
	syn match MtQuoteSingle +'\S\{-}'+
	hi default link MtQuoteSingle MtQuote
endif
if b:MtQuoteDoubleEn
	syn match MtQuoteDouble +".\{-}"+
	hi default link MtQuoteDouble MtQuote
endif
if b:MtCodeSingleEn
	syn match MtCodeSingle +`.\{-}`+
	hi default link MtCodeSingle MtCode
endif

" -- Standard Marks --
syn region MtComment start="</" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtCommentMark
syn region MtMeat start="<_" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtMeatMark
syn region MtKey start="<\*" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtIssue start="<?" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtSolved start="</?" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtTodo start="<!" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtDone start="</!" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtTag start="</\=#" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline contains=MtTagSign
syn match MtTagSign "[.=+\-\:]\ze[^>]" contained
syn region MtLink start="<[~]" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtAutoLink
syn region MtQuote start="<:" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline contains=@MtKeys
syn region MtCode start="<|" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtNull start="<\\" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet
syn match MtSolvedC "</\=?.\{-}//.\{-}>" contains=MtCommentInSolvedC
syn match MtDoneC "</\=!.\{-}//.\{-}>" contains=MtCommentInSolvedC
syn match MtCommentInSolvedC "//.\{-}\ze>" contained

hi default link MtTagSign MtSign
hi default link MtSolvedC MtSolved
hi default link MtDoneC MtDone
hi default link MtCommentInSolvedC MtComment

" -- Note & Bibl --
syn match MtNote "^\s*(#\d\+)" contains=@MtIndent
syn match MtLinkToNote "([~]\d\+)"
syn match MtBibl "^\s*\[#\d\+\]" contains=@MtIndent
syn match MtLinkToBibl "\[[~]\d\+\]"

hi default link MtNote MtTag
hi default link MtLinkToNote MtLink
hi default link MtBibl MtTag
hi default link MtLinkToBibl MtLink

" -- Strict Marks --
syn region MtMeatSt start="<<_"  end="_>>" contains=@MtLinet,@MtMeatMark
syn region MtIssueSt start="<<?"  end="?>>" contains=@MtLinet,@MtKeys
syn region MtSolvedSt start="<</?" end="?>>" contains=@MtLinet,@MtKeys
syn region MtTodoSt start="<<!"  end="!>>" contains=@MtLinet,@MtKeys
syn region MtDoneSt start="<</!" end="!>>" contains=@MtLinet,@MtKeys
syn region MtLinkSt start="<<[~]"  end="[~]>>" contains=@MtLinet,@MtAutoLink
syn region MtNullSt start="<<\\" end="\\>>" contains=@MtLinet

hi default link MtMeatSt MtMeat
hi default link MtIssueSt MtIssue
hi default link MtSolvedSt MtSolved
hi default link MtTodoSt MtTodo
hi default link MtDoneSt MtDone
hi default link MtLinkSt MtLink
hi default link MtNullSt MtNull

" == Lines ==
" Lines are effective marks for you only need to mark the beginning of it.
syn match MtCommentLine  "^\s*//[^/].*$\|\s\+//[^/].*$" contains=@MtLinet,@MtCommentMark
syn match MtLineSign "^\s*/\=[_*?!:|~]\s*" contained contains=MtIndent
syn match MtMeatLine "^\s*_ .*$" contains=MtLineSign,MtWhiteTail,@MtMeatMark
syn match MtIssueLine "^\s*? .*$" contains=MtLineSign,MtWhiteTail,@MtKeys
syn match MtSolvedLine "^\s*/? .*$" contains=MtLineSign,MtWhiteTail,@MtKeys
syn match MtSolvedCLine "^\s*/\=? .*\s\+//[^/].*$" contains=MtLineSign,MtWhiteTail,@MtKeys,MtCommentLine
syn match MtTodoLine "^\s*! .*$" contains=MtLineSign,MtWhiteTail,@MtKeys
syn match MtDoneLine "^\s*/! .*$" contains=MtLineSign,MtWhiteTail,@MtKeys
syn match MtDoneCLine "^\s*/\=! .*\s\+//[^/].*$" contains=MtLineSign,MtWhiteTail,@MtKeys,MtCommentLine
syn match MtQuoteLine "^\s*: .*$" contains=MtLineSign,MtWhiteTail,@MtQuoteMark
syn match MtMdRefLine "^\t*>\s.*$" contains=@MtLinet,@MtQuoteMark
syn match MtCodeLine "^\t*|\s.*$" contains=MtLineSign,MtWhiteTail
syn match MtLinkLine "^\s*\~ .*$" contains=MtLineSign,MtWhiteTail,@MtAutoLink
syn match MtNullLine "^\s*\\\\.*$" contains=@MtLinet

hi default link MtCommentLine MtComment
hi default link MtMeatLine MtMeat
hi default link MtIssueLine MtIssue
hi default link MtSolvedLine MtSolved
hi default link MtSolvedCLine MtSolved
hi default link MtTodoLine MtTodo
hi default link MtDoneLine MtDone
hi default link MtDoneCLine MtDone
hi default link MtLinkLine MtLink
hi default link MtQuoteLine MtQuote
hi default link MtMdRefLine MtQuote
hi default link MtCodeLine MtCode
hi default link MtNullLine MtNull
hi default link MtLineSign MtSign

" == Blocks ==
" Blocks are special "strict marks" for multi-line comment, ref and code.
" A block is treated as one paragraph in folding, even without any indentation.
" The level is determined by its heading line.
" Don't indent them, let them keep the original format, then it's easy to copy & paste them.
syn region MtCommentBlock matchgroup=MtBlockFence start="<</\ze[^?!]\|<</$" end="/>>" contains=@MtLinet,@MtCommentMark,@MtCommentBlockLine
syn region MtQuoteBlock matchgroup=MtBlockFence start="<<:"  end=":>>" contains=@MtLinet,@MtQuoteMark,@MtQuoteBlockLine
syn region MtCodeBlock matchgroup=MtBlockFence start="<<|" end="|>>" contains=@MtLinet,@MtCodeBlockLine

hi default link MtCommentBlock MtComment
hi default link MtQuoteBlock MtQuote
hi default link MtCodeBlock MtCode
hi default link MtBlockFence MtSign
