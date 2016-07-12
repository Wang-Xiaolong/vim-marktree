syn region MtCBlock matchgroup=MtBlockFence start="<<c|" end="|>>" contains=@MtLinet,cStatement,cLabel,cConditional,cRepeat,cType,cStructure,cStorageClass,cNumber,cString,cComment,cCommentLine

syn keyword cStatement goto break return continue asm contained
syn keyword cLabel case default contained
syn keyword cConditional if else switch contained
syn keyword cRepeat while for do contained
syn keyword cType int long short char void signed unsigned float double bool contained
syn keyword cStructure struct union enum typedef contained
syn keyword cStorageClass static register auto volatile extern const inline contained

syn match cNumber "\d\+\(u\=l\{0,2}\|ll\=u\)\>" contained
syn match cNumber "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>" contained

syn region cString start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"+ end=+"+ extend contained

syn region cComment start="/\*" end="\*/" contains=@MtCommentMark extend contained
syn region cCommentLine start="//" skip="\\$" end="$" keepend contains=@MtCommentMark extend contained

hi def link cStatement Statement
hi def link cLabel Label
hi def link cConditional Conditional
hi def link cRepeat Repeat
hi def link cType Type
hi def link cStructure Structure
hi def link cStorageClass StorageClass
hi def link cNumber Number
hi def link cString String
hi def link cComment Comment
hi def link cCommentLine Comment
