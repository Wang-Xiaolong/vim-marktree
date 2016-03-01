" syn/marktree.vim to define marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" sync from start to correctly hi long blocks
syn sync fromstart
syn sync maxlines=100

" init
function! MtSyntaxInit()
	let s:optstr = matchstr(getline(1), '<mt\S*>')
	if s:optstr == ""
		let b:T1LvlCnt = 0
		let b:T2LvlCnt = 0
		let b:MtMwEn = 0
		let b:MtKwEn = 0
		let b:MtQwEn = 0
		let b:MtDwEn = 0
		let b:MtTwEn = 0
		let b:MtLwEn = 0
		let b:MtRwEn = 0
		let b:MtRSingleEn = 0
		let b:MtRDoubleEn = 0
		let b:MtESingleEn = 0
		return
	endif
	let b:T1LvlCnt = strlen(substitute(s:optstr, "[^=]", "", "g"))
	let b:T2LvlCnt = strlen(substitute(s:optstr, "[^-]", "", "g"))
	let b:MtMwEn = strlen(substitute(s:optstr, "[^_]", "", "g"))
	let b:MtKwEn = strlen(substitute(s:optstr, "[^*]", "", "g"))
	let b:MtQwEn = strlen(substitute(s:optstr, "[^?]", "", "g"))
	let b:MtDwEn = strlen(substitute(s:optstr, "[^!]", "", "g"))
	let b:MtTwEn = strlen(substitute(s:optstr, "[^#]", "", "g"))
	let b:MtLwEn = strlen(substitute(s:optstr, "[^~]", "", "g"))
	let b:MtRwEn = strlen(substitute(s:optstr, "[^:]", "", "g"))
	let b:MtRSingleEn = strlen(substitute(s:optstr, "[^']", "", "g"))
	let b:MtRDoubleEn = strlen(substitute(s:optstr, "[^\"]", "", "g"))
	let b:MtESingleEn = strlen(substitute(s:optstr, "[^`]", "", "g"))
endfunction

call MtSyntaxInit()

" == Clusters ==
syn cluster MtKeys contains=MtKey
syn cluster MtMeats contains=MtMeat,MtMeatSt
syn cluster MtLinks contains=MtLink,MtLinkSt,@MtAutoLink
syn cluster MtGeneralMark contains=@MtKeys,MtTag,MtIssue,MtSolved,MtTodo,MtDone,MtIssueSt,MtSolvedSt,MtTodoSt,MtDoneSt
syn cluster MtCommentMark contains=@MtGeneralMark,@MtMeats,@MtLinks
syn cluster MtMeatMark contains=@MtGeneralMark,MtComment,MtCommentLine
syn cluster MtRefMark contains=@MtGeneralMark,MtComment,MtCommentLine,@MtMeats,@MtLinks,MtNull,MtNullSt
syn cluster MtTitleMark contains=@MtGeneralMark,@MtLinks,MtComment,MtCommentLine,MtCommentBlock

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
syn match MtEmail "[a-z0-9_\.-]\+@[\da-z\.-]\+\.[a-z\.]\{2,6}"
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
" Title0 is the head block from the beginning of file to the first empty line;
" Title1 is as '== Title 1 =='
"   Start with at least 2 equal signs at the start-of-line,
"   End with at least 2 equal signs.
"   The count of beginning equal signs indicates the level of title,
"   2 equal signs each level, e.g. :
"     '== Title 1 ==' is level 0, that will never be folded;
"     '==== Title 1.1 ==' is level 1
"   You can also extend the tailing equal signs to make it a separator, e.g.
"     '====== Title 1.1.1 ================================================='
" Title2 is as '-- Title 2 --'
"   Start with 2 minus signs at the start-of-line,
"   End with at least 2 minus signs, that could also be extend to a separator.
"   The level is just lower than the lowest Title1.
" Title3 is as '#Title 3#'
"   Start with a sharp sign, tab indented, end also with a sharp sign. 
"   It has the same level of the text it decorates.

syn region MtTitle0 start="\%^" end="^\s*$" contains=@MtTitleMark,@MtLinet,@MtAutoLink,MtCommentLine,MtOption
syn match MtTitle1 "^==\+[^=].\+==\+" contains=@MtTitleMark,MtWhiteTail
syn match MtTitle2 "^--\+[^-].\+--\+" contains=@MtTitleMark,MtWhiteTail
syn match MtTitle "^\t*#.\+#\s*$\|^\t*#.\+#  " contains=@MtTitleMark,@MtLinet
syn match MtTitleEx "^\s*|_.\{-}\(_|\|$\)" contains=@MtTitleMark,MtWhiteTail

hi default link MtTitle0 MtTitle
hi default link MtTitle1 MtTitle
hi default link MtTitle2 MtTitle
hi default link MtTitleEx MtTitle

" == Marks ==
" Mark     SB  Standard  Strict      Line    Word   Contain            Meaning
" Comment  /C  </abc>    <</abc/>>   //abc          General+Meat+Link  Explanations or remarks beyond the original text
"  InCode                            >> abc
" Meat     _M  <_abc>    <<_abc_>>   _ abc   _abc   General+Comment    Important parts to underline
" Key      *K  <*abc>                        *abc                      Keyword that can hook
" Issue    ?Q  <?abc>    <<?abc?>>   ? abc   ?abc   Key                Things not quite sure
"  Solved      </?abc>   <</?abc?>>  /? abc  /?abc  Key                Solved issue
" Todo     !D  <!abc>    <<!abc!>>   ! abc   !abc   Key                Words push to some actions
"  Done        </!abc>   <</!abc!>>  /! abc  /!abc  Key                Completed tasks
" Tag      #T  <#abc>                        #abc                      Anchor or meta data
"  Hidden      </#abc>                       /#abc                     Hidden anchor
" Link     ~L  <~abc>    <<~abc~>>   ~ abc   ~abc                      Link to anchor or external content
"  Url                                                                 Url/Email is auto recognized
" Ref      :R  <:abc>    <<:abc:>>   : abc   :abc   General+Meat+Link  From other source
"              "abc"                 > abc   'abc'    +Comment+Null
" Code     |E  <|abc>    <<|abc|>>   | abc          Comment in Code    Code or embedded objects
"              `abc`     ```abc```                                       such as tables and charts
" Null     \N  <\abc>    <<\abc\>>   \\abc                             To be ignored

" -- Word Marks --
" Very light marks that mark only 1 word. All optional:
syn match MtWordSign "[*~:]\|\<_\|/\=[?!#]" contained
hi default link MtWordSign MtSign
if b:MtMwEn
	syn match MtMeatW "\<_\S\{-1,}\>" contains=MtWordSign 
	hi default link MtMeatW MtMeat
	syn cluster MtMeats add=MtMeatW
endif
if b:MtKwEn
	syn match MtKeyW "\*[^ \t=]\S\{-}\>" contains=MtWordSign
	hi default link MtKeyW MtKey
	syn cluster MtKeys add=MtKeyW
endif
if b:MtQwEn
	syn match MtIssueW "?\S\{-}\>" contains=MtWordSign
	syn match MtSolvedW "/?\S\{-}\>" contains=MtWordSign
	hi default link MtIssueW MtIssue
	hi default link MtSolvedW MtSolved
	syn cluster MtGeneralMark add=MtIssueW,MtSolvedW
endif
if b:MtDwEn
	syn match MtTodoW "![^ \t=]\S\{-}\>" contains=MtWordSign
	syn match MtDoneW "/![^ \t=]\S\{-}\>" contains=MtWordSign
	hi default link MtTodoW MtTodo
	hi default link MtDoneW MtDone
	syn cluster MtGeneralMark add=MtTodoW,MtDoneW
endif
if b:MtTwEn
	syn match MtTagW "#[^ \t\d]\S\{-}\>" contains=MtWordSign
	hi default link MtTagW MtTag
	syn cluster MtGeneralMark add=MtTagW
endif
if b:MtLwEn
	syn match MtLinkW "[~][^ \t\d>~]\S\{-}\>" contains=MtWordSign
	hi default link MtLinkW MtLink
	syn cluster MtLinks add=MtLinkW
endif
if b:MtRwEn
	syn match MtRefW ":[^ \t-():]\S\{-}\>" contains=MtWordSign
	hi default link MtRefW MtRef
endif
if b:MtRSingleEn
	syn match MtRefSingle +'\S\{-}'+
	hi default link MtRefSingle MtRef
endif
if b:MtRDoubleEn
	syn match MtRefDouble +".\{-}"+
	hi default link MtRefDouble MtRef
endif
if b:MtESingleEn
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
syn region MtTag start="</\=#" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtLink start="<[~]" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtAutoLink
syn region MtRef start="<:" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline contains=@MtKeys
syn region MtCode start="<|" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtNull start="<\\" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet

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
syn match MtTodoLine "^\s*! .*$" contains=MtLineSign,MtWhiteTail,@MtKeys
syn match MtDoneLine "^\s*/! .*$" contains=MtLineSign,MtWhiteTail,@MtKeys
syn match MtRefLine "^\s*: .*$" contains=MtLineSign,MtWhiteTail,@MtRefMark
syn match MtMdRefLine "^\t*>\s.*$" contains=@MtLinet,@MtRefMark
syn match MtCodeLine "^\t*|\s.*$" contains=MtLineSign,MtWhiteTail
syn match MtLinkLine "^\s*\~ .*$" contains=MtLineSign,MtWhiteTail,@MtAutoLink
syn match MtNullLine "^\s*\\\\.*$" contains=@MtLinet

hi default link MtCommentLine MtComment
hi default link MtMeatLine MtMeat
hi default link MtIssueLine MtIssue
hi default link MtSolvedLine MtSolved
hi default link MtTodoLine MtTodo
hi default link MtDoneLine MtDone
hi default link MtLinkLine MtLink
hi default link MtRefLine MtRef
hi default link MtMdRefLine MtRef
hi default link MtCodeLine MtCode
hi default link MtNullLine MtNull
hi default link MtLineSign MtSign

syn cluster MtCommentBlockLine contains=MtMeatLine,MtIssueLine,MtSolvedLine,MtTodoLine,MtDoneLine,MtLinkLine
syn cluster MtRefBlockLine contains=MtCommentLine,MtMeatLine,MtIssueLine,MtSolvedLine,MtTodoLine,MtDoneLine,MtLinkLine,MtNullLine

" == Blocks ==
" Blocks are special "strict marks" for multi-line comment, ref and code.
" A block is treated as one paragraph in folding, even without any indentation.
" The level is determined by its heading line.
" Don't indent them, let them keep the original format, then it's easy to copy & paste them.
syn region MtCommentBlock start="<</[^?!]" end="/>>" contains=@MtLinet,@MtCommentMark,@MtCommentBlockLine
syn region MtRefBlock start="<<:"  end=":>>" contains=@MtLinet,@MtRefMark,@MtRefBlockLine
syn region MtCodeBlock start="<<\p\{-}|" end="|>>" contains=@MtLinet,MtCodeComment
syn region MtGhCodeBlock start="```" end="```" contains=@MtLinet,MtCodeComment
syn match MtCodeComment "^>>[^>].*$" contained contains=MtWhiteTail,@MtCommentMark

hi default link MtCommentBlock MtComment
hi default link MtRefBlock MtRef
hi default link MtCodeBlock MtCode
hi default link MtGhCodeBlock MtCode
hi default link MtCodeComment MtComment
