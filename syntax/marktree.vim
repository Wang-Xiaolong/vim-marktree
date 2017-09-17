" syn/marktree.vim to define marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" sync from start to correctly highlight long blocks
syn sync fromstart
syn sync maxlines=500

" == Init Function: Get options from MtOption mark ==========================
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

" == Clusters ===============================================================
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

" == Small Stuff ============================================================
" It is here before the Lines and Regions because if not so,
" Lines and Regions may can't be recognized.
" Seems for VIM, code at the back make effects.

" -- Indent & errors in lines --
syn match MtIndent "^\s\+" contains=MtIndentTab,MtTabAfterSpace
syn match MtIndentTab "^\t\+" contained
syn match MtWhiteTail "\s\+$"
syn match MtTabAfterSpace " \+\t\+" contained

syn cluster MtLinet contains=MtIndent,MtWhiteTail

hi default link MtTabAfterSpace MtWhiteTail

" -- URL & Email --
syn match MtUrl "[a-z]\{3,6}:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*"
syn match MtEmail "[a-z0-9_\.-]\+@[0-9a-z\.-]\+\.[a-z\.]\{2,6}"

syn cluster MtAutoLink contains=MtUrl,MtEmail

hi default link MtEmail MtUrl

" -- Signs of a list --
syn match MtSign "^\t*[\*+\-] \(\[.\?\]\)\?" contains=MtIndent,MtSignIssue,MtSignTodo
syn match MtNumSign "^\t*\d\+\. \(\[.\?\]\)\?" contains=MtIndent,MtSignIssue,MtSignTodo
syn match MtLetterSign "^\t*[a-zA-Z]\. \(\[.\?\]\)\?" contains=MtIndent,MtSignIssue,MtSignTodo
syn match MtSignTodo "\[ \?\]" contained
syn match MtSignIssue "\[?\]" contained

hi default link MtNumSign MtSign
hi default link MtLetterSign MtSign
hi default link MtSeparator MtSign
hi default link MtSignTodo MtTodo
hi default link MtSignIssue MtIssue

" -- Note & Bibl --
syn match MtNote "^\s*(#\d\+)" contains=@MtIndent
syn match MtLinkToNote "([~]\d\+)"
syn match MtBibl "^\s*\[#\d\+\]" contains=@MtIndent
syn match MtLinkToBibl "\[[~]\d\+\]"

hi default link MtNote MtTag
hi default link MtLinkToNote MtLink
hi default link MtBibl MtTag
hi default link MtLinkToBibl MtLink

" -- Seperator --
syn match MtSeparator "^\s*-\{6,}\s*$\|^\s\+\*\s\+\*\s\+\*\s*$" contains=@MtLinet

" == Titles =================================================================
syn match MtHeadSign0 "\\$" contained
syn match MtHead0 "\%^\(.*\\\n\)*.*[^\\]$" contains=@MtHeadMark,MtHeadSign0,MtOption
syn match MtHeadSign1 "^==\+\|==\+$\|\\$" contained
syn match MtHead1 "^==\(.*\\\n\)*.*[^\\]$" contains=@MtHeadMark,MtHeadSign1
syn match MtHeadSign2 "^--\+\|--\+$\|\\$" contained
syn match MtHead2 "^--\(.*\\\n\)*.*[^\\]$" contains=@MtHeadMark,MtHeadSign2
syn match MtHeadSign "^\t*#\|#$\|\\$" contained
syn match MtHead "^\t*# \(.*\\\n\)*.*[^\\]$" contains=@MtHeadMark,MtHeadSign

hi default link MtHead0 MtHead
hi default link MtHead1 MtHead
hi default link MtHead2 MtHead
hi default link MtHeadSign0 MtHeadSign
hi default link MtHeadSign1 MtHeadSign
hi default link MtHeadSign2 MtHeadSign
hi default link MtHeadSign MtFence

" -- Option mark --
syn match MtOption "<mt\S*>" contained
hi default link MtOption MtSign

" == Marks ==================================================================
" -- Word Marks --
" Very light marks that mark only 1 word. All optional:
if b:MtKeyWEn
	syn match MtKeyW "\*\k*\>"
	hi default link MtKeyW MtKey
	syn cluster MtKeys add=MtKeyW
endif
if b:MtIssueWEn
	syn match MtIssueW "?\k*\>"
	syn match MtSolvedW "/?\k*\>"
	syn match MtSolvedWC "/\=?\k*</.*>" contains=MtComment
	hi default link MtIssueW MtIssue
	hi default link MtSolvedW MtSolved
	hi default link MtSolvedWC MtSolved
	syn cluster MtGeneralMark add=MtIssueW,MtSolvedW,MtSolvedWC
endif
if b:MtTodoWEn
	syn match MtTodoW "!\k*\>"
	syn match MtDoneW "/!\k*\>"
	syn match MtDoneWC "/\=!\k*</.*>" contains=MtComment
	hi default link MtTodoW MtTodo
	hi default link MtDoneW MtDone
	hi default link MtDoneWC MtDone
	syn cluster MtGeneralMark add=MtTodoW,MtDoneW,MtDoneWC
endif
if b:MtTagWEn
	syn match MtTagW "#\(\k*\.\)*\k*\>"
	hi default link MtTagW MtTag
	syn cluster MtGeneralMark add=MtTagW
endif
if b:MtLinkWEn
	syn match MtLinkW "[~]\(\k*\.\)*\k*\>"
	hi default link MtLinkW MtLink
	syn cluster MtLinks add=MtLinkW
endif
if b:MtQuoteSingleEn
	syn match MtQuoteSingle +'\S\{-}'+ contains=MtQuoteSingleSign
	syn match MtQuoteSingleSign +'+ contained
	hi default link MtQuoteSingle MtQuote
	hi default link MtQuoteSingleSign MtSign
endif
if b:MtQuoteDoubleEn
	syn match MtQuoteDouble +".\{-}"+ contains=MtQuoteDoubleSign
	syn match MtQuoteDoubleSign +"+ contained
	hi default link MtQuoteDouble MtQuote
	hi default link MtQuoteDoubleSign MtSign
endif
if b:MtCodeSingleEn
	syn match MtCodeSingle +`.\{-}`+ contains=MtCodeSingleSign
	syn match MtCodeSingleSign +`+ contained
	hi default link MtCodeSingle MtCode
	hi default link MtCodeSingleSign MtSign
endif

" -- Standard Marks --
syn region MtComment matchgroup=MtFence start="</" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtCommentMark
syn region MtMeat matchgroup=MtFence start="<_" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtMeatMark
syn region MtKey matchgroup=MtFence start="<\*" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline
syn region MtIssue matchgroup=MtFence start="<?" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtSolved matchgroup=MtFence start="</?" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtTodo matchgroup=MtFence start="<!" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtDone matchgroup=MtFence start="</!" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtKeys
syn region MtTag matchgroup=MtFence start="</\=#" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline contains=MtTagSign
syn match MtTagSign "[.=+\-\:]\ze[^>]" contained
syn region MtLink matchgroup=MtFence start="<[~]" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$" contains=@MtLinet,@MtAutoLink
syn region MtQuote matchgroup=MtFence start="<:" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline contains=@MtKeys
syn region MtCode matchgroup=MtFence start="<|" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline
syn region MtNull start="<\\" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet
syn match MtSolvedC "</\=?.\{-}//.\{-}>" contains=MtCommentInSolvedC
syn match MtDoneC "</\=!.\{-}//.\{-}>" contains=MtCommentInSolvedC
syn match MtCommentInSolvedC "//.\{-}\ze>" contained

hi default link MtTagSign MtSign
hi default link MtSolvedC MtSolved
hi default link MtDoneC MtDone
hi default link MtCommentInSolvedC MtComment

" -- Lines --
" Lines are effective marks for you only need to mark the beginning of it.
syn match MtCommentLine "//.*$" contains=MtWhiteTail,@MtCommentMark
syn match MtLineSign "^\s*/\=[_*?!:|~]\s*" contained contains=MtIndent
syn match MtMeatLine "^\s*_ .*$" contains=MtLineSign,MtWhiteTail,@MtMeatMark
syn match MtIssue "??.*$" contains=MtWhiteTail,@MtKeys
syn match MtSolved "/??.*$" contains=MtWhiteTail,@MtKeys
syn match MtSolved "/\=??.*//.*$" contains=MtWhiteTail,@MtKeys,MtCommentLine
syn match MtTodo "!!.*$" contains=MtWhiteTail,@MtKeys
syn match MtDone "/!!.*$" contains=MtWhiteTail,@MtKeys
syn match MtDone "/\=!!.*//.*$" contains=MtWhiteTail,@MtKeys,MtCommentLine
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

" -- Strict Marks --
syn region MtMeatSt matchgroup=MtFence start="<<_"  end="_>>" contains=@MtLinet,@MtMeatMark
syn region MtIssueSt matchgroup=MtFence start="<<?"  end="?>>" contains=@MtLinet,@MtKeys
syn region MtSolvedSt matchgroup=MtFence start="<</?" end="?>>" contains=@MtLinet,@MtKeys
syn region MtTodoSt matchgroup=MtFence start="<<!"  end="!>>" contains=@MtLinet,@MtKeys
syn region MtDoneSt matchgroup=MtFence start="<</!" end="!>>" contains=@MtLinet,@MtKeys
syn region MtLinkSt matchgroup=MtFence start="<<[~]"  end="[~]>>" contains=@MtLinet,@MtAutoLink
syn region MtNullSt matchgroup=MtFence start="<<\\" end="\\>>" contains=@MtLinet

hi default link MtMeatSt MtMeat
hi default link MtIssueSt MtIssue
hi default link MtSolvedSt MtSolved
hi default link MtTodoSt MtTodo
hi default link MtDoneSt MtDone
hi default link MtLinkSt MtLink
hi default link MtNullSt MtNull

" -- Blocks --
" Blocks are special "strict marks" for multi-line comment, ref and code.
" A block is treated as one paragraph in folding, even without any indentation.
" The level is determined by its heading line.
" Don't indent them, let them keep the original format, then it's easy to copy & paste them.
syn region MtCommentBlock matchgroup=MtBlockFence start="<</\ze[^?!]\|<</$" end="/>>" contains=@MtLinet,@MtCommentMark,@MtCommentBlockLine
syn region MtQuoteBlock matchgroup=MtBlockFence start="<<:"  end=":>>" contains=@MtLinet,@MtQuoteMark,@MtQuoteBlockLine
syn region MtCodeBlock matchgroup=MtBlockFence start="<<|" end="|>>" contains=@MtLinet
hi default link MtCommentBlock MtComment
hi default link MtQuoteBlock MtQuote
hi default link MtCodeBlock MtCode

" -- Special Code Blocks: line comment in code blocks for code review --
" -- 1. // C, Java, Go, PHP ...
syn region MtCode1Block matchgroup=MtBlockFence start="<<//|" end="|>>" contains=@MtLinet,MtCode1Comment
syn match MtCode1Comment "//.*$" contains=@MtCommentMark contained

hi default link MtCode1Block MtCode
hi default link MtCode1Comment MtComment

" -- 2. # Shell, Perl, Python, Ruby, PowerShell, PHP, Make
syn region MtCode2Block matchgroup=MtBlockFence start="<<#|" end="|>>" contains=@MtLinet,MtCode2Comment
syn match MtCode2Comment "#.*$" contains=@MtCommentMark contained

hi default link MtCode2Block MtCode
hi default link MtCode2Comment MtComment

" -- 3. ; Assemble, Lisp
syn region MtCode3Block matchgroup=MtBlockFence start="<<;|" end="|>>" contains=@MtLinet,MtCode3Comment
syn match MtCode3Comment ";.*$" contains=@MtCommentMark contained

hi default link MtCode3Block MtCode
hi default link MtCode3Comment MtComment

" -- 4. -- SQL, Ada, Lua, VHDL
syn region MtCode4Block matchgroup=MtBlockFence start="<<--|" end="|>>" contains=@MtLinet,MtCode4Comment
syn match MtCode4Comment "--.*$" contains=@MtCommentMark contained

hi default link MtCode4Block MtCode
hi default link MtCode4Comment MtComment

" -- 5. " Vim
syn region MtCode5Block matchgroup=MtBlockFence start=+<<"|+ end="|>>" contains=@MtLinet,MtCode5Comment
syn match MtCode5Comment +".*$+ contains=@MtCommentMark contained

hi default link MtCode5Block MtCode
hi default link MtCode5Comment MtComment

