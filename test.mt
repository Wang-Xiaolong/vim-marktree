*File Head <mt===---^option_in_1st_line> can \
have multiple lines (Level 0) and put a ==, --, ?, *, ! or other element at \
the beginning of it will not cause it hi like normal or head0/1. \
File Head can contain *key <*key region> <#tag> <~link> ?issue <?issue region>\
<??issue>region?> </?solved region> !todo <!todo region> <!!todo>region!>\
still/!done ?natural_solved</commend region> !natual_done//comment line \
still File Head ?natural_solved//comment line\
still
Normal text (Level 6)
	Lower level by adding more heading tabs (Level 7)
== Dual-lane Head (Level 2)
==== higher level Dual-lane Head (Level 1)
====== higher and higher level Dual-lane Head (Level 0)
== Dual-lane Head with an end (you can't write after it)==
== Dual-lane Heads divide =====================================================
== Dual-lane Head can contain \
   multiple lines
== and can also \
have an end ==
== fold test(Level 2), the next line should also be Level 2 \
==========
== and can contain "==" in it, and //comment line
== For multiple lines //comment line \
is like //this and (*key, <?issue>, <!!todo>region!>)\
//this (*key, <??issue>region?> </!done>)====

-- Single-lane Head (Level 3)
---- lower level Single-lane Head (Level 4)
------ lower and lower Single-lane Head (Level 5)
-- Single-lane Head with an end (you can't write after it) --
-- Single-lane Heads can also divide ------------------------------------------
-- Single-lane Head can also contain \
   multiple lines
-- and can also \
   have an end --
-- and can contain '--' in it
-- Single-lane Head can *contain ?word !marks\
and region marks like <*key region> <?issue region> </?solved region>\
<!todo region> </!done region> </comment region> <//comment>region/>\
<??issue>region?> </??solved>region?> <!!todo>region!> </!!done>region!>\
<#tag region> <~link region> <_meat region> <_ meat>region_>\
//comment line *key\
//comment line --

## Normal Head, whose level is equal to normal text (Level 6)
	## lower level Normal Head (Level 7)
	## Normal Head with an end ##  and you can write after it,
	that indicates you can't put a "##" in it.
	## Normal Head can contain \
	   multiple lines
	## and can also \
	   have an end ##
### 3# doesn't work, it's strict
## the end is also strict # ### #### ######
## can have //comment line
## even in //multiple line\
mode //yeah *key ##

//Comment line
Normal//Comment line
/// 3/ not work, it's strict
//Comment line can contain *keyword <*key region> <#tag region> <~link region>
//and ?issue_word <?issue region> <??issue>region?>
//and !todo_word <!todo region> <!!todo>region!>
//and <_meat region> <_ meat>region_>
</Comment region, can have > >> >>> -> => >= in it>
<//strict Comment region for a> a>b
and multiple lines and can contain *keyword <?issue region> <!!todo>region!>
_ meat line
comment??issue line
comment!!todo line
comment??solved line//solution
comment!!done line</solution>
/>
[/Comment block (level 6)/]
Normal [/Comment block can expand to multiple lines, (level 6)
like this. (level 7)/]

?Issue_word Normal ?another_Issue_word, a lone ? should not be effected.
?Issue_word//can be natually solved by a Comment line after it
?Issue_word</can be natually solved by a Comment region after it>
?Issue_word<//and the Comment region can contain multiple lines,
like this/>
?multi</issue>?word</in>?one</line>
/?solved_Issue_word, a lone /? should not be effecte.
Normal/?solved_Issue_word//and Comment after it

??Issue line
Normal??Issue line
??? 3? not work, it's strict
??Issue line//can be natually solved by a Comment line after it
???Issue line//3? no work, strict
??Issue line</can be natually solved by a Comment region after it>
???Issue line//3? no work, strict
???Issue line</3? no work, strict>
??It's</a little hack>that??you can</write>multiple??issue lines</in>one line.
/??solved Issue line
Nomral/??solved Issue line
/???3? not work, strict
/??solved Issue line//can also have Comment line after it
/??solved Issue line</can also have Comment region after it>Normal
/???solved Issue line//3? not work, strict
/???solved Issue line</3? not work, strict>

Normal<?Issue region, can have > >a >> >>> a>> -> => >= in it>Normal
<<?not work>, =<?not work>, strict
<??strict Issue region is for where you need a>b|a>, or
expand to multiple lines?>
</?solved Issue region>
</??solved strict>Issue region?>

!Todo_word Normal !another_Todo_word a lone ! no hi
!Todo_word//can be natually done by a Comment line after it
!Todo_word</can be nutually done by a Comment region after it>
!Todo_word<//and the strict Comment region can contain multiple lines,
like this/>
!multi</Done>!word</in>!one</line>
/!Done_word, a lone /? should not be effecte.
Normal/!Done_word//and Comment after it

!!Todo line
Normal!!Todo line
!!! 3! not work, it's strict
!!Todo line//can be natually solved by a Comment line after it
!!!Issue line//3? no work, strict
!!Todo line</can be natually solved by a Comment region after it>
!!!Issue line//3? no work, strict
!!!Issue line</3? no work, strict>
!!It's</a little hack>that!!you can</write>multiple!!todo lines</in>one line.
/!!Done line
Nomral/!!Done line
/!!!3! not work, strict
/!!Done line//can also have Comment line after it
/!!Done line</can also have Comment region after it>Normal
/!!!Done line//3? not work, strict
/!!!Done line</3? not work, strict>

Normal<!Todo region, can have > >a >> a>> >>> -> => >= in it>Normal
<!!strict Todo region is for a> a>b or
multiple lines!>
</!Done region>
</!!strict>Done region!>

*Key_word Normal *another_Key_word a lone * no hi
**2_stars doesn't work, strict!
<*Key region > >a >> a>> >>> -> => >=.> <<*not work> =<*not work>

<#Tag region > >a >> a>> -> => >=.> <<#not work> =<#not work>
<~Link region > >a >> a>> -> => >=.> <<~not work> =<~not work>
(#1) Note (~1) Link to note
[#1] Bibl [~1] Link to Bibl
~ link line
tailing ~ link line not allowed for individual ~ is home dir in my mind
<~ strict link>region~>

_ Meat line *key <?issue region> <!!todo>region!> </comment> //comment line
Normal_ no work
  _snap, no work
  _    work
  _	tab after, work
	_ tab before, work, !done</comment region> still meat
Normal _ Meat line *key ?solved//comment line
<_Meat region>
<_ strict Meat region for a> a>b and
multiple line
and can contain </comment region> //comment line
*key <?issue region> <!!todo>region!>
??issue line
??solved line//solution
still meat_>

\\Junk line
	\\ tab and Junk line
	  \\ tab, space and Junk line
	  \\\ 3\ no work, strict
Normal<\Junk region > >a >> a>> >>> -> => >=.>Normal
<\\strict Junk region for a> a>b and
multiple lines\>

| Code line
	| tab and Code line
	 | space no work
	|snap to | no work
	|	tab after | also work
<|Code region > >a >> a>> -> => >= ;>
[|Code block is for
multiple line|]
C, Java, Go, PHP [//|
Code //Comment line *key <?issue region> <!!todo>region!> ?solved//solution
Code /* Comment region *key <?issue region> <!!todo>region!>
?solved</solution> !!done line//comment
//comment line
*/ Code |]
Shell, Perl, Python, Ruby, Power, PHP, Makefile [#|
# comment line *key <?issue region> <!!todo>region!> ?solved//solution
|]
Assembly, Lisp [;|
; comment line *key <?issue region> <!!todo>region!> ?solved//solution
|]
SQL, Ada, Lua, VHDL [--|
-- comment line *key <?issue region> <!!todo>region!> !done//solution
|]
	Vim ["|
" comment line *key <?issue region> <!!todo>region!> !done//solution
|]
Marktree [marktree|
== Head1
-- Head2
## Head3
|]
Block folding test
Level 6 [/
Level 6
/] Level 6
	Level 7 [/
Level 7
		Level 7
/] Level 7
		Level 8
[| Level 8
	|] Level 8

> Quote prefix
	> can be after tabs
	>must have a space after it
	>
	> ^or just a empty line
		>> quote in a quote
		>>>>>>>>>>>> _ meat line ok ^_^
* list sign star
	+ list sign plus
	- list sign minus
	+must have space after it
	- _ meet line ok
(#1) (~1)
[#1] [~1]
