" syn/marktree.vim to define marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" sync from start to correctly hi long blocks
syn sync fromstart
syn sync maxlines=100

" == Small Stuff ==
" It is here before the Lines and Regions because if not so,
" Lines and Regions may can't be recognized.
" Seems for VIM, code at the back make effects.
syn match MtIndent "^\s\+" contains=MtIndentTab,MtTabAfterSpace
syn match MtIndentTab "^\t\+" contained
syn match MtWhiteTail "\s\+$"
syn match MtTabAfterSpace " \+\t\+" contained
syn match MtSign "^\t*[\*+\-] " contains=MtIndent
syn match MtNumSign "^\t*\d\+\. " contains=MtIndent
syn match MtSeparator "^\s*-\{6,}\s*$\|^\s\+\*\s\+\*\s\+\*\s*$" contains=@MtLinet
syn match MtUrl "[a-z]\{3,6}:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*"
syn match MtEmail "[a-z0-9_\.-]\+@[\da-z\.-]\+\.[a-z\.]\{2,6}"

syn cluster MtLinet contains=MtIndent,MtWhiteTail
syn cluster MtAutoLink contains=MtUrl,MtEmail

hi default link MtTabAfterSpace MtWhiteTail
hi default link MtNumSign MtSign
hi default link MtSeparator MtSign
hi default link MtEmail MtUrl

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
" Keywords, Questions and Tags can be marked inside a Title.

syn region MtTitle0 start="\%^" end="^\s*$" contains=@MtTitleMarks,@MtLinet,@MtAutoLink
syn match MtTitle1 "^==\+[^=].\+==\+" contains=@MtTitleMarks,MtWhiteTail
syn match MtTitle2 "^--\+[^-].\+--\+" contains=@MtTitleMarks,MtWhiteTail
syn match MtTitle "^\t*#.\+#\s*$\|^\t*#.\+#  " contains=@MtTitleMarks,@MtLinet

syn cluster MtTitleMarks contains=MtKey,MtIssue,MtSolved,MtTag,MtLink

hi default link MtTitle0 MtTitle
hi default link MtTitle1 MtTitle
hi default link MtTitle2 MtTitle

" == Marks ==
" Small marks within one line
"   Comment: </Explanations or remarks, beyond the original text>
"   Meat: <_Important sentences, usually underlined on paper>
"   Keyword: <*Words that can hook>
"   Question: <?Things that I'm not quite sure>
"   Solved: </?Now I'm sure>
"   Todo: <!Words that push me to do something>
"   Done: </!Now it's done>
"   Tag: <#Important words or phrases> that could be </#referenced elsewhere>
"   Link: <~Reference tags or external content>
" List (*, + or -) and number (1. 2. 3. ...) signs are also rendered here.

syn region MtComment start="</" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtCommentMark
syn region MtMeat start="<_" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtMeatMark
syn region MtKey start="<\*" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtIssue start="<?" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,MtKey
syn region MtSolved start="</?" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,MtKey
syn region MtTodo start="<!" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,MtKey
syn region MtDone start="</!" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,MtKey
syn region MtTag start="</\=#" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtLink start="<[~]" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet,@MtAutoLink
syn region MtRef start="<:" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtCode start="<|" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>" oneline
syn region MtNull start="<\\" skip="[^ \-=>]>={1}\|[^ \-=>]>>\+" end="[^ \-=>]>\|^\s*$" contains=@MtLinet

" -- Strict Marks --
syn region MtMeatS start="<<_"  end="_>>" contains=@MtLinet,@MtMeatMark
syn region MtIssueS start="<<?"  end="?>>" contains=@MtLinet,MtKey
syn region MtSolvedS start="<</?" end="?>>" contains=@MtLinet,MtKey
syn region MtTodoS start="<<!"  end="!>>" contains=@MtLinet,MtKey
syn region MtDoneS start="<</!" end="!>>" contains=@MtLinet,MtKey
syn region MtLinkS start="<<[~]"  end="[~]>>" contains=@MtLinet,@MtAutoLink
syn region MtNullS start="<<\\" end="\\>>" contains=@MtLinet

hi default link MtMeatS MtMeat
hi default link MtIssueS MtIssue
hi default link MtSolvedS MtSolved
hi default link MtTodoS MtTodo
hi default link MtDoneS MtDone
hi default link MtLinkS MtLink
hi default link MtNullS MtNull

syn cluster MtGeneralMark contains=MtKey,MtTag,MtIssue,MtSolved,MtTodo,MtDone,MtIssueS,MtSolvedS,MtTodoS,MtDoneS
syn cluster MtCommentMark contains=@MtGeneralMark,MtMeat,MtLink,MtMeatS,@MtAutoLink
syn cluster MtMeatMark contains=@MtGeneralMark,MtComment
syn cluster MtRefMark contains=@MtGeneralMark,MtComment,MtMeat,MtLink,MtNull,MtMeatS,MtDoneS,MtLinkS,MtNullS,@MtAutoLink

" == Lines ==
" Lines are effective marks for you only need to mark the beginning of it.
syn match MtCommentLine  "^\s*//[^/].*$\|\s\+//[^/].*$" contains=@MtLinet,@MtCommentMark
syn match MtMeatLine "^\s*_ .*$" contains=@MtLinet,@MtMeatMark
syn match MtIssueLine "^\s*? .*$" contains=@MtLinet,MtKey
syn match MtSolvedLine "^\s*/? .*$" contains=@MtLinet,MtKey
syn match MtTodoLine "^\s*! .*$" contains=@MtLinet,MtKey
syn match MtDoneLine "^\s*/! .*$" contains=@MtLinet,MtKey
syn match MtRefLine "^\s*: .*$" contains=@MtLinet,@MtRefMark
syn match MtMdRefLine "^\t*>\s.*$" contains=@MtLinet,@MtRefMark
syn match MtCodeLine "^\t*|\s.*$" contains=@MtLinet
syn match MtLinkLine "^\s*\~ .*$" contains=@MtLinet,@MtAutoLink
syn match MtNullLine "^\s*\\\\ .*$" contains=@MtLinet

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
