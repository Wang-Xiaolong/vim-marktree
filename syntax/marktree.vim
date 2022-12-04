" syn/marktree.vim to define marktree leaves
" xiaolong.wang@intel.com from Dec.2015

" include extensions parsed from the option in ftplugin
for s:ext in b:MtExtList
	let s:extpath = b:MtPath.'/syntax/marktree.'.s:ext.'.vim'
	execute 'source '.s:extpath
endfor

" sync from start to correctly highlight long blocks
syn sync fromstart
syn sync maxlines=500

" == Clusters ===============================================================
syn cluster MtGeneralMark contains=MtMeat,MtKey,MtIssue,MtFix,MtTodo,MtDone,
  \ MtTag,MtTagHi,MtLink,MtFade
syn cluster MtCommentLineMark contains=@MtGeneralMark,MtWhiteTail
syn cluster MtMeatLineMark contains=@MtGeneralMark,
  \ MtComment,MtCommentLine,MtCommentBlock
syn cluster MtGeneralLine contains=MtMeadLine,MtIssueLine,MtFixLine,
  \ MtTodoLine,MtDoneLine,MtLinkLine,MtFadeLine
syn cluster MtStrictCommentRegionMark contains=@MtGeneralMark,@MtGeneralLine,
  \ MtComment,MtCommentLine
syn cluster MtStrictMeatRegionMark contains=@MtGeneralMark,@MtGeneralLine,
  \ MtComment,MtCommentLine,MtCommentBlock

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
syn match MtUrl "\S\@<![a-z]\{3,6}://\S*"
syn match MtEmail "[A-Za-z0-9_\.-]\+@[0-9a-z\.-]\+\.[a-z\.]\{2,6}"

hi def link MtUrl MtLink
hi def link MtEmail MtLink

" -- Signs of a list --
syn match MtSign "\(^\t*\)\@<=\([*+\-]\|\d\+[.)]\|[a-zA-Z][.)]\) \@="

" -- Note & Bibl --
syn match MtNote "\(^\t*\)\@<=(#\d\+)"
syn match MtLinkToNote "([~]\d\+)"
syn match MtBibl "\(^\t*\)\@<=\[#\d\+\]"
syn match MtLinkToBibl "\[[~]\d\+\]"

hi def link MtNote MtTag
hi def link MtLinkToNote MtLink
hi def link MtBibl MtTag
hi def link MtLinkToBibl MtLink

" -- Quote prefix --
syn match MtQuotePrefix "\(^\t*\)\@<=>\+\( \|$\)\@="
hi def link MtQuotePrefix MtFence

" == Marks ==================================================================
" -- Word -------------------------------------------------------------------
" Very light marks for only 1 word. All optional.
if b:MtKeyWordEn
	syn match MtKeyWordFence "*" contained
	hi def link MtKeyWordFence MtFence
	syn match MtKey "[\*]\@<!\*\k*\>" contains=MtKeyWordFence
	syn match MtKeyLooseWordFence "\*\*" contained
	hi def link MtKeyLooseWordFence MtFence
	syn match MtKey "[\*]\@<!\*\*\*\@!\S\+" contains=MtKeyLooseWordFence
endif
if b:MtIssueWordEn
	syn match MtIssueWordFence "?" contained
	hi def link MtIssueWordFence MtFence
	syn match MtIssue "?\@<!?\k*\>" contains=MtIssueWordFence
	syn match MtFix "?\@<!?\k*\([</]/\)\@=" contains=MtIssueWordFence
	syn match MtFixWordFence "/?" contained
	hi def link MtFixWordFence MtFence
	syn match MtFix "/?\k*\>" contains=MtFixWordFence

	syn match MtIssueLooseWordFence "??" contained
	hi def link MtIssueLooseWordFence MtFence
	syn match MtIssue "?\@<!???\@!\S\+" contains=MtIssueLooseWordFence
	syn match MtFixLooseWordFence "/??" contained
	hi def link MtFixLooseWordFence MtFence
	syn match MtFix "/???\@!\S\+" contains=MtFixLooseWordFence
	syn match MtFix "\(?\@<!\|/\)???\@!\S\+\([</]/\)\@="
	  \ contains=MtIssueLooseWordFence,MtFixLooseWordFence
endif
if b:MtTodoWordEn
	syn match MtTodoWordFence "!" contained
	hi def link MtTodoWordFence MtFence
	syn match MtTodo "!\@<!!\k*\>" contains=MtTodoWordFence
	syn match MtDone "!\@<!!\k*\([</]/\)\@=" contains=MtTodoWordFence
	syn match MtDoneWordFence "/!" contained
	hi def link MtDoneWordFence MtFence
	syn match MtDone "/!\k*\>" contains=MtDoneWordFence

	syn match MtTodoLooseWordFence "!!" contained
	hi def link MtTodoLooseWordFence MtFence
	syn match MtTodo "!\@<!!!!\@!\S\+" contains=MtTodoLooseWordFence
	syn match MtDoneLooseWordFence "/!!" contained
	hi def link MtDoneLooseWordFence MtFence
	syn match MtDone "/!!!\@!\S\+" contains=MtDoneLooseWordFence
	syn match MtDone "\(!\@<!\|/\)!!!\@!\S\+\([</]/\)\@="
	  \ contains=MtTodoLooseWordFence,MtDoneLooseWordFence
endif
if b:MtTagWordEn
	syn match MtTagWordFence "#" contained
	hi def link MtTagWordFence MtFence
	syn match MtTag "\S\@<!#\k*\>" contains=MtTagWordFence
	syn match MtTag "\S\@<!#\d\+\([-./]\d\+\)\+" contains=MtTagWordFence
	syn match MtTagLooseWordFence "##" contained
	hi def link MtTagLooseWordFence MtFence
	syn match MtTag "\S\@<!###\@!\S\+" contains=MtTagLooseWordFence

	syn match MtTagHiWordFence "\*#" contained
	hi def link MtTagHiWordFence MtFence
	syn match MtTagHi "\S\@<!\*#\k*\>" contains=MtTagHiWordFence
	syn match MtTagHiLooseWordFence "\*##" contained
	hi def link MtTagHiLooseWordFence MtFence
	syn match MtTagHi "\S\@<!\*###\@!\S\+" contains=MtTagHiLooseWordFence
endif
if b:MtLinkWordEn
	syn match MtLinkWordFence "[~]" contained
	hi def link MtLinkWordFence MtFence
	syn match MtLink "\S\@<![~]\k*\>" contains=MtLinkWordFence
	syn match MtLinkLooseWordFence "[~][~]" contained
	hi def link MtLinkLooseWordFence MtFence
	syn match MtLink "\S\@<![~][~][~]\@!\S\+" contains=MtLinkLooseWordFence
endif

" -- Standard Region --------------------------------------------------------
" For phrase and sentense, limited to oneline and pure (contain nothing)
syn region MtComment matchgroup=MtFence start="[=<]\@<!</"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtMeat matchgroup=MtFence start="[=<]\@<!<_"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtKey matchgroup=MtFence start="[=<]\@<!<\*"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtIssue matchgroup=MtFence start="[=<]\@<!<?"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtFix matchgroup=MtFence start="[=<]\@<!</?"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtTodo matchgroup=MtFence start="[=<]\@<!<!"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtDone matchgroup=MtFence start="[=<]\@<!</!"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtTag matchgroup=MtFence start="[<=]\@<!</\=#"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtTagHi matchgroup=MtFence start="[<=]\@<!<\*#"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtLink matchgroup=MtFence start="[<=]\@<!<[~]"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtCode matchgroup=MtFence start="[<=]\@<!<|"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline
syn region MtFade start="[<=]\@<!<\\"
  \ skip="[-= ]>\|>=" end=">\@<!>>\@!" oneline

" -- Line -------------------------------------------------------------------
" For single line element, probably a sentense. May contain other marks.
" Dual-sign
syn region MtCommentLine matchgroup=MtFence start="[/:]\@<!///\@!" end="$"
  \ contains=@MtCommentLineMark oneline keepend
syn region MtFadeLine start="^\s*\\\\\\\@!" end="$"
  \ contains=@MtLinet oneline keepend
" Single-sign
syn region MtIssueLine matchgroup=MtFence start="\S\@<!?\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtFixLine matchgroup=MtFence start="\S\@<!/?\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtFixLine matchgroup=MtFence start="\S\@<!/\=?\s\+"
  \ end="\([</]/\)\@=" contains=MtKey oneline
syn region MtTodoLine matchgroup=MtFence start="\S\@<!!\s\+" end="$"
  \ contains=MtWhiteTail,MtKey oneline keepend
syn region MtDoneLine matchgroup=MtFence start="\S\@<!/!\s\+" end="$"
  \ contains=WtWhiteTail,MtKey oneline keepend
syn region MtDoneLine matchgroup=MtFence start="\S\@<!/\=!\s\+"
  \ end="\([</]/\)\@=" contains=MtKey oneline
syn region MtMeatLine matchgroup=MtFence start="\S\@<!_\s\+" end="$"
  \ contains=@MtLinet,@MtMeatLineMark oneline keepend
syn region MtLinkLine matchgroup=MtFence start="\(^\s*\)\@<=[~]\s\+" end="$"
  \ contains=@MtLinet oneline keepend
syn region MtCodeLine matchgroup=MtFence start="\(^\t*\)\@<=|\s\+" end="$"
  \ contains=@MtLinet oneline keepend

hi def link MtCommentLine MtComment
hi def link MtIssueLine MtIssue
hi def link MtFixLine MtFix
hi def link MtTodoLine MtTodo
hi def link MtDoneLine MtDone
hi def link MtMeatLine MtMeat
hi def link MtLinkLine MtLink
hi def link MtFadeLine MtFade
hi def link MtCodeLine MtCode

" -- Strict Region ----------------------------------------------------------
" For > using element, or big one with multi lines. May contain other marks.
syn region MtComment matchgroup=MtFence start="<//" end="/>"
  \ contains=@MtLinet,@MtStrictCommentRegionMark
syn region MtIssue matchgroup=MtFence start="<?\s"  end="?>"
  \ contains=@MtLinet,MtKey
syn region MtFix matchgroup=MtFence start="</?\s" end="?>"
  \ contains=@MtLinet,MtKey
syn region MtTodo matchgroup=MtFence start="<!\s"  end="!>"
  \ contains=@MtLinet,MtKey
syn region MtDone matchgroup=MtFence start="</!\s" end="!>"
  \ contains=@MtLinet,MtKey
syn region MtFade start="<\\\\" end="\\>" contains=@MtLinet
syn region MtMeat matchgroup=MtFence start="<_\s"  end="_>"
  \ contains=@MtLinet,@MtStrictMeatRegionMark
syn region MtLink matchgroup=MtFence start="<[~]\s" end="[~]>"
  \ contains=@MtLinet,MtKey

" -- Blocks -----------------------------------------------------------------
" Blocks are for multiple lines of comment and code.
" A block is treated as one paragraph in folding, even without any indentation.
" The level is determined by its heading line.
" Don't indent them, let them keep the original format, then
" it's easy to copy & paste them.
syn region MtCommentBlock matchgroup=MtBlockFence start="</$" end="/>"
  \ contains=@MtLinet,@MtStrictCommentRegionMark
syn region MtCodeBlock matchgroup=MtBlockFence start="<|$" end="|>"
  \ contains=@MtLinet
hi def link MtCommentBlock MtComment
hi def link MtCodeBlock MtCode
hi def link MtBlockFence MtFence

" -- Special Code Blocks: line comment in code blocks for code review --
" -- 1. // C, Java, Go, PHP ...
syn region MtCode1Block matchgroup=MtBlockFence start="<//$" end="//>"
  \ contains=@MtLinet,MtCode1Comment
syn match MtCode1Comment "//.*$" contains=@MtCommentLineMark contained
syn region MtCode1Comment start="/\*" end="\*/"
  \ contains=@MtLinet,@MtStrictCommentRegionMark contained

hi def link MtCode1Block MtCode
hi def link MtCode1Comment MtComment

" -- 2. # Shell, Perl, Python, Ruby, PowerShell, PHP, Make
syn region MtCode2Block matchgroup=MtBlockFence start="<#$" end="#>"
  \ contains=@MtLinet,MtCode2Comment
syn match MtCode2Comment "#.*$" contains=@MtCommentLineMark contained

hi def link MtCode2Block MtCode
hi def link MtCode2Comment MtComment

" -- 3. ; Assemble, Lisp
syn region MtCode3Block matchgroup=MtBlockFence start="<;$" end=";>"
  \ contains=@MtLinet,MtCode3Comment
syn match MtCode3Comment ";.*$" contains=@MtCommentLineMark contained

hi def link MtCode3Block MtCode
hi def link MtCode3Comment MtComment

" -- 4. -- SQL, Ada, Lua, VHDL
syn region MtCode4Block matchgroup=MtBlockFence start="<--$" end="-->"
  \ contains=@MtLinet,MtCode4Comment
syn match MtCode4Comment "--.*$" contains=@MtCommentLineMark contained

hi def link MtCode4Block MtCode
hi def link MtCode4Comment MtComment

" -- 5. " Vim
syn region MtCode5Block matchgroup=MtBlockFence start=+<"$+ end=+">+
  \ contains=@MtLinet,MtCode5Comment
syn match MtCode5Comment +".*$+ contains=@MtCommentLineMark contained

hi def link MtCode5Block MtCode
hi def link MtCode5Comment MtComment

" -- Final: Marktree, used in marktree.mt to show syntax colors
"  and avoid unexpected folding
syn region MtMarktreeBlock matchgroup=MtBlockFence start="<marktree|$" end="|>"
  \ contains=ALL

" == Headings =================================================================
syn cluster MtHeadMark contains=@MtGeneralMark,MtComment,@MtLinet
syn match MtFollowSign "\(^\t*\)\@<=\\\s\@=" contained
syn region MtHead1 matchgroup=MtFence start="^==\+[^=]\@=" end="\(==\+\)\=\n\(\\\s\)\@!"
  \ contains=@MtHeadMark,MtFollowSign,MtCommentLine keepend
syn region MtHead1Hi matchgroup=MtFence start="^*==\+[^=]\@=" end="\(==\+\)\=\n\(\\\s\)\@!"
  \ contains=@MtHeadMark,MtFollowSign,MtCommentLine keepend
syn region MtHead2 matchgroup=MtFence start="^--\+[^-]\@=" end="\(--\+\)\=\n\(\\\s\)\@!"
  \ contains=@MtHeadMark,MtFollowSign,MtCommentLine keepend
syn region MtHead2Hi matchgroup=MtFence start="^*--\+[^-]\@=" end="\(--\+\)\=\n\(\\\s\)\@!"
  \ contains=@MtHeadMark,MtFollowSign,MtCommentLine keepend
syn region MtHead matchgroup=MtFence start="\(^\t*\)\@<=#\s\+"
  \ end="\s\+#\S\@!\|\n\(\t*\\\s\)\@!" keepend
  \ contains=@MtHeadMark,MtFollowSign,MtCommentLine
syn region MtHeadHi matchgroup=MtFence start="\(^\t*\)\@<=\*#\s\+"
  \ end="\s\+#\S\@!\|\n\(\t*\\\s\)\@!" keepend
  \ contains=@MtHeadMark,MtFollowSign,MtCommentLine
syn match MtOption "<mt\S\{-}>\|\%^(\S\{-})" contained
syn region MtHead0 start="\%^" end="\n\(\\\s\)\@!" keepend
  \ contains=@MtHeadMark,MtFollowSign,MtOption,MtCommentLine

hi def link MtHead0 MtHead1
hi def link MtHead2 MtHead
hi def link MtHeadHi MtTagHi
hi def link MtHead1Hi MtTagHi
hi def link MtHead2Hi MtTagHi
hi def link MtFollowSign MtFence
hi def link MtOption MtSign

