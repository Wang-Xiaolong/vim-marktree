" syn/marktree.vim to define marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" sync from start to correctly highlight long blocks
syn sync fromstart
syn sync maxlines=500

" == Clusters ===============================================================
syn cluster MtMeats contains=MtMeat
syn cluster MtLinks contains=MtLink,@MtAutoLink
syn cluster MtGeneralMark contains=MtKey,MtTag,MtIssue,MtSolved,MtTodo,MtDone
syn cluster MtCommentMark contains=@MtGeneralMark,@MtMeats,@MtLinks
syn cluster MtMeatMark contains=@MtGeneralMark,MtComment,MtCommentLine
syn cluster MtHeadMark contains=@MtGeneralMark,@MtLinks,MtComment,MtCommentLine,MtCommentBlock,@MtLinet
syn cluster MtCommentBlockLine contains=MtMeatLine,MtIssueLine,MtSolvedLine,MtTodoLine,MtDoneLine,MtLinkLine

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

hi def link MtTabAfterSpace MtWhiteTail

" -- URL & Email --
syn match MtUrl "[a-z]\{3,6}:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*"
syn match MtEmail "[a-z0-9_\.-]\+@[0-9a-z\.-]\+\.[a-z\.]\{2,6}"

syn cluster MtAutoLink contains=MtUrl,MtEmail

hi def link MtEmail MtUrl

" -- Signs of a list --
syn match MtSign "^\t*[\*+\-] " contains=MtIndent
syn match MtNumSign "^\t*\d\+\. " contains=MtIndent
syn match MtLetterSign "^\t*[a-zA-Z]\. " contains=MtIndent

hi def link MtNumSign MtSign
hi def link MtLetterSign MtSign

" -- Note & Bibl --
syn match MtNote "^\s*(#\d\+)" contains=@MtIndent
syn match MtLinkToNote "([~]\d\+)"
syn match MtBibl "^\s*\[#\d\+\]" contains=@MtIndent
syn match MtLinkToBibl "\[[~]\d\+\]"

hi def link MtNote MtTag
hi def link MtLinkToNote MtLink
hi def link MtBibl MtTag
hi def link MtLinkToBibl MtLink

" -- Seperator --
syn match MtSeparator "^\s*-\{6,}\s*$\|^\s\+\*\s\+\*\s\+\*\s*$"
  \ contains=@MtLinet

hi def link MtSeparator MtSign

" == Marks ==================================================================
" -- Word Marks --
" Very light marks that mark only 1 word. All optional:
if b:MtKeyWordEn
	syn match MtKey "\*\k*\>"
endif
if b:MtIssueWordEn
	syn match MtIssueWordFence "?" contained
	hi def link MtIssueWordFence MtFence
	syn match MtIssue "?\@<!?\k*\>" contains=MtIssueWordFence
	syn match MtSolved "?\@<!?\k*\(</\)\@=" nextgroup=MtComment
	  \ contains=MtIssueWordFence
	syn match MtSolved "?\@<!?\k*\(//\)\@=" nextgroup=MtCommentLine
	  \ contains=MtIssueWordFence
	syn match MtSolvedWordFence "/?" contained
	hi def link MtSolvedWordFence MtFence
	syn match MtSolved "/?\k*\>" contains=MtSolvedWordFence
endif
if b:MtTodoWordEn
	syn match MtTodoWordFence "!" contained
	hi def link MtTodoWordFence MtFence
	syn match MtTodo "!\@<!!\k*\>" contains=MtTodoWordFence
	syn match MtDone "!\@<!!\k*\(</\)\@=" nextgroup=MtComment
	  \ contains=MtTodoWordFence
	syn match MtDone "!\@<!!\k*\(//\)\@=" nextgroup=MtCommentLine
	  \ contains=MtTodoWordFence
	syn match MtDoneWordFence "/!" contained
	hi def link MtDoneWordFence MtFence
	syn match MtDone "/!\k*\>" contains=MtDoneWordFence
endif

" -- Standard Marks --
syn region MtComment matchgroup=MtFence start="</"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$"
  \ contains=@MtLinet,@MtCommentMark
syn region MtMeat matchgroup=MtFence start="<_"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$"
  \ contains=@MtLinet,@MtMeatMark
syn region MtKey matchgroup=MtFence start="<\*"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline
syn region MtIssue matchgroup=MtFence start="<?"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$"
  \ contains=@MtLinet,MtKey
syn region MtSolved matchgroup=MtFence start="</?"
  \ skip="->\+\|=>\+\|>>\+\|>\+=\| >\+" end=">\|^\s*$"
  \ contains=@MtLinet,MtKey
syn region MtTodo matchgroup=MtFence start="<!"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$"
  \ contains=@MtLinet,MtKey
syn region MtDone matchgroup=MtFence start="</!"
  \ skip="->\+\|=>\+\|>>\+\|>\+=\| >\+" end=">\|^\s*$"
  \ contains=@MtLinet,MtKey,MtCommentInSolved
syn region MtTag matchgroup=MtFence start="</\=#"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline
  \ contains=MtTagSign
syn match MtTagSign "[.=+\-\:]\ze[^>]" contained
syn region MtLink matchgroup=MtFence start="<[~]"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>\|^\s*$"
  \ contains=@MtLinet,@MtAutoLink
syn region MtCode matchgroup=MtFence start="<|"
  \ skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]\zs>" oneline
syn region MtJunk start="<\\" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+"
  \ end="[^ \-=>]>\|^\s*$" contains=@MtLinet

hi def link MtTagSign MtSign
hi def link MtCommentInSolved MtComment

" -- Lines --
" Lines are effective marks for you only need to mark the beginning of it.
syn region MtCommentLine matchgroup=MtFence start="/\@<!///\@!" end="$"
  \ contains=MtWhiteTail,@MtCommentMark oneline keepend
syn match MtLineSign "^\s*/\=[_*?!:|~]\s*" contained contains=MtIndent
syn match MtMeatLine "^\s*_ .*$" contains=MtLineSign,MtWhiteTail,@MtMeatMark
syn region MtIssue matchgroup=MtFence start="?\@<!???\@!" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtSolved matchgroup=MtFence start="/???\@!" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtSolved matchgroup=MtFence start="/???\@!\|?\@<!???\@!" end="\([</]/\)\@="
  \ contains=MtKey oneline
syn region MtTodo matchgroup=MtFence start="!!" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtDone matchgroup=MtFence start="/!!" end="$"
  \ contains=WtWhiteTail,MtKey oneline keepend
syn region MtDone matchgroup=MtFence start="!!" end="\(//\)\@="
  \ contains=MtKey oneline
syn match MtCodeLine "^\t*|\s.*$" contains=MtLineSign,MtWhiteTail
syn match MtLinkLine "^\s*\~ .*$" contains=MtLineSign,MtWhiteTail,@MtAutoLink
syn match MtJunkLine "^\s*\\\\.*$" contains=@MtLinet

hi def link MtCommentLine MtComment
hi def link MtMeatLine MtMeat
hi def link MtIssueLine MtIssue
hi def link MtSolvedLine MtSolved
hi def link MtTodoLine MtTodo
hi def link MtDoneLine MtDone
hi def link MtLinkLine MtLink
hi def link MtCodeLine MtCode
hi def link MtJunkLine MtJunk
hi def link MtLineSign MtSign

" -- Strict Marks --
syn region MtComment matchgroup=MtFence start="<//" end="/>"
  \ contains=@MtLinet,@MtCommentMark,@MtCommentBlockLine
syn region MtMeat matchgroup=MtFence start="<<_"  end="_>>"
  \ contains=@MtLinet,@MtMeatMark
syn region MtIssue matchgroup=MtFence start="<??"  end="?>"
  \ contains=@MtLinet,MtKey
syn region MtSolved matchgroup=MtFence start="</??" end="?>"
  \ contains=@MtLinet,MtKey
syn region MtTodo matchgroup=MtFence start="<<!"  end="!>>"
  \ contains=@MtLinet,MtKey
syn region MtDone matchgroup=MtFence start="<</!" end="!>>"
  \ contains=@MtLinet,MtKey
syn region MtLink matchgroup=MtFence start="<<[~]"  end="[~]>>"
  \ contains=@MtLinet,@MtAutoLink
syn region MtJunk matchgroup=MtFence start="<<\\" end="\\>>"
  \ contains=@MtLinet

" -- Blocks --
" Blocks are for multiple lines of comment and code.
" A block is treated as one paragraph in folding, even without any indentation.
" The level is determined by its heading line.
" Don't indent them, let them keep the original format, then it's easy to copy & paste them.
syn region MtCommentBlock matchgroup=MtBlockFence
  \ start="\[/" end="/\]"
  \ contains=@MtLinet,@MtCommentMark,@MtCommentBlockLine
syn region MtCodeBlock matchgroup=MtBlockFence start="<<|" end="|>>"
  \ contains=@MtLinet
hi def link MtCommentBlock MtComment
hi def link MtCodeBlock MtCode

" -- Special Code Blocks: line comment in code blocks for code review --
" -- 1. // C, Java, Go, PHP ...
syn region MtCode1Block matchgroup=MtBlockFence start="<<//|" end="|>>"
  \ contains=@MtLinet,MtCode1Comment
syn match MtCode1Comment "//.*$" contains=@MtCommentMark contained
syn region MtCode1Comment start="/\*" end="\*/"
  \ contains=@MtCommentMark contained

hi def link MtCode1Block MtCode
hi def link MtCode1Comment MtComment

" -- 2. # Shell, Perl, Python, Ruby, PowerShell, PHP, Make
syn region MtCode2Block matchgroup=MtBlockFence start="<<#|" end="|>>"
  \ contains=@MtLinet,MtCode2Comment
syn match MtCode2Comment "#.*$" contains=@MtCommentMark contained

hi def link MtCode2Block MtCode
hi def link MtCode2Comment MtComment

" -- 3. ; Assemble, Lisp
syn region MtCode3Block matchgroup=MtBlockFence start="<<;|" end="|>>"
  \ contains=@MtLinet,MtCode3Comment
syn match MtCode3Comment ";.*$" contains=@MtCommentMark contained

hi def link MtCode3Block MtCode
hi def link MtCode3Comment MtComment

" -- 4. -- SQL, Ada, Lua, VHDL
syn region MtCode4Block matchgroup=MtBlockFence start="<<--|" end="|>>"
  \ contains=@MtLinet,MtCode4Comment
syn match MtCode4Comment "--.*$" contains=@MtCommentMark contained

hi def link MtCode4Block MtCode
hi def link MtCode4Comment MtComment

" -- 5. " Vim
syn region MtCode5Block matchgroup=MtBlockFence start=+<<"|+ end="|>>"
  \ contains=@MtLinet,MtCode5Comment
syn match MtCode5Comment +".*$+ contains=@MtCommentMark contained

hi def link MtCode5Block MtCode
hi def link MtCode5Comment MtComment

" -- Final: Marktree, used in marktree.mt to show syntax colors
"  and avoid unexpected folding
syn region MtMarktreeBlock matchgroup=MtBlockFence start="<<marktree|" end="|>>"
  \ contains=ALL

" == Headings =================================================================
syn match MtHeadSign1 "^==\+\|==\+$\|\\$" contained
syn match MtHead1 "^==\(.*\\\n\)*.*[^\\]$" contains=@MtHeadMark,MtHeadSign1
syn match MtHeadSign2 "^--\+\|--\+$\|\\$" contained
syn match MtHead2 "^--\(.*\\\n\)*.*[^\\]$" contains=@MtHeadMark,MtHeadSign2
syn match MtHeadSign "^\t*###\@!\|\\\n\|#\@<!###\@!" contained
syn match MtHead "^\t*###\@!\(.*\\\n\)*.\{-}\(#\@<!###\@!\|[^\\]$\)"
  \ contains=@MtHeadMark,MtHeadSign
syn match MtHeadSign0 "\\$" contained
syn match MtOption "<mt\S*>" contained
syn match MtHead0 "\%^\(.*\\\n\)*.*[^\\]$"
  \ contains=@MtHeadMark,MtHeadSign0,MtOption

hi def link MtHead0 MtHead
hi def link MtHead1 MtHead
hi def link MtHead2 MtHead
hi def link MtHeadSign0 MtHeadSign
hi def link MtHeadSign1 MtHeadSign
hi def link MtHeadSign2 MtHeadSign
hi def link MtHeadSign MtFence
hi def link MtOption MtSign

