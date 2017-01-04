The MARKTREE light-weight markup language <mt^>
xiaolong.wang@intel.com


== Marks ==
-- Basic and Strict Marks --
Mark	Basic		Strict		Contains
Meat	<_Meat>		<<_Meat_>>	All except Ref & Code
Key	<*Key>
Junk	<\Junk>		<<\Junk\>>
Issue	<?Issue>	<<?Issue?>>	Key
Solved	</?Solved>	<</?Solved?>>	Key
Todo	<!Todo>		<<!Todo!>>	Key
Done	</!Done>	<</!Done!>>	Key
Tag	<#Tag>
Link	<~Link>		<<~Link~>>
Comment </Comment>	<</Comment/>>	All except Ref & Code
Ref	<:Ref>		<<:Ref:>>	All
Code	<|code>		<<|Code|>>
-- Lines --
_ Meat Line
\\Junk Line
? Issue Line
/? Solved Line
! Todo Line
/! Done Line
~ Link Line
//Comment Line
> Ref Line
| Code Line

== Titles ==
-- 4 levels of titles --

== Title Level 1 ==
==   Title Level 2 ==

== Compare with Markdown ==
