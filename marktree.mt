The MARKTREE light-weight markup language <mt^>
xiaolong.wang@intel.com

Like Markdown, the Marktree markup language is light-weight.
  For me, it means you can easily get the meaning of its gramma elements
   without learning; and it won't annoy you much if you don't know them.
 It was designed to implements two things: 'Tree' and 'Mark'.
	'Tree' means you can assign levels to your text lines.
	 The levels are visually distinct.
	 And with folding support, you can browse from headings,
	  and keep just the section you read in you console windows.
	'Mark' means you can mark emphasis, keyword, issue, todo or comment
	  in your text, with a few strait forward signs.
	 The signs are in unified format, and easy to be understand.
	 And with syntax highlighting, they are more distinct to you.
The document is organized as following:
 Chapter "Tree of Text" will introduce the format of normal test;
 Chapter "Headings" will describe the format of titles and headings,
  those are with higher levels than normal text.
 Chapter "Marks" will show you the format of the marks.

== Trees of Text: Indent-based, like writing code ==
In normal writing, content is organized paragraph by paragraph;
  and inside a paragraph, it's sentence by sentence.
Marktree is different: it recommends a code-like style:
  function by function, line by line, and indent to show levels.

== Headings ==
-- File Title --
-- Section Heading --
-- Normal Heading --

# Normal #

== Marks ==
-- Standard and Strict Marks --
Mark	Standard	Strict		Contains
Meat	<_Meat>		<_ Meat_>	All except Ref & Code
Key	<*Key>
Junk	<\Junk>		<\\Junk\>
Issue	<?Issue>	<? Issue?>	Key
Solved	</?Solved>	</? Solved?>	Key
Todo	<!Todo>		<! Todo!>	Key
Done	</!Done>	</! Done!>	Key
Tag	<#Tag>
Link	<~Link>		<~ Link~>
Comment </Comment>	<//Comment/>	All except Ref & Code
Code	<|Code>		<| Code|>

<*Key > -> => >> >= >>> =>>> ->>>> >>>> >>>>= end>
<?Issue > -> => >> >= *key end>
<!Todo > -> => >> >= *key end>
</?Solved 1 > 2-> 3=> 4>> 5>= 6 >> 7 >= 8-->>> 9==>>> 10>>=== 11*key
12 //MtComment In Solved with *key
13//MtComment In Solved2 with *key>
-- Lines --
	_ Meat Line
	\\Junk Line
Normal ? Issue Line contains *key
Normal /? Solved Line contains *key
Normal ? Solved Line contains *key//Comment
Normal ! Todo Line contains *key
Normal /! Done Line contains *key
Normal ! Done Line contains *key//Comment
	~ Link Line
Normal//Comment Line contains *key ?issue !todo
| Code Line
-- Words --
Normal *Key ?Issue /?Solved1 ?Solved</2>Normal> !Todo /!Done1 !Done</2>Normal>

-- URL --
URL in a normal sentense: http://www.intel.com
Punctuation is allowed before and after a URL:http://www.intel.com!
forget_a_space_herehttp://abc.com
