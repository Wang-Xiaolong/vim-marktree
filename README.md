# The Marktree note taking language
The "Marktree" here is a lightweight markup language for note taking, when using it with your plain text:

1. You have hierarchies with folding capability.
  * First you have multiple levels of titles, e.g.
```
File Title: From file head to the first blank line

== Title 1 =======================================
==== Title 1.1 ==
====== Title 1.1.1 ==
-- Title 1.1.1.1 --
---- Title 1.1.1.1.1 --
# Title in Text #
        # Next Level Title in Text #
```
  * Then you have multiple levels of text, e.g.
```
Paragraph 1, Level 1
   Still paragraph 1
  Still paragraph 1
        Paragraph 2, level 2
	 Still paragraph 2
	  Still paragraph 2
Paragraph 3, Level 3
```
2. You can highlight important sentences, keywords as well as issues and to-dos.
  * You can use 
```
	This is <_an important sentence that should be underlined>.
	This is a <*keyword>, this is an <?issue>, and this is a <!TODO item>.
	When a </?issue> or </!TODO item> is solved or done, it could be simply down-graded.
	And this is a <#Tag>, this is a <~Link>
```
  * You can also highlight the whole line
```
	_ an important line to underline
	? a issue line
	! a TODO item
	~ a long link
	> a quote line, just like in markdown
	| a code line
	// a comment line, just like in C++, Java or C#
```
The grammar is easy and lightweight.
It will not bother too much after being pasted into emails.
It will still looking fine even in Notepad.

For detailed grammar rule, please refer to "marktree_grammar.mt"

In the "vim" folder there locates the vim plugin that can highlight and fold marktree format text file.

The name is from "Markdown" and "XmasTree".
