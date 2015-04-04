---
layout: post
title: "Building an Object-Oriented Parasitic Metalanguage"
date: 2008-07-31 07:34:00
updated: 2008-12-11 00:09:54
permalink: /2008/07/building-object-oriented-parasitic.html
---
It's all about pattern matching. The rest is just details.

My [last post on OMeta#](http://www.moserware.com/2008/06/ometa-who-what-when-where-why.html) focused on what it is and the vision I have for its future. Briefly, [OMeta](http://www.cs.ucla.edu/~awarth/ometa/) is a new language that makes it easier to design programming languages in an [object-oriented](http://en.wikipedia.org/wiki/Object_oriented) fashion using very few lines of quite readable code. [OMeta#](http://www.codeplex.com/ometasharp) is my attempt to support OMeta on the [.NET runtime](http://en.wikipedia.org/wiki/Common_Language_Runtime). My main strategy has been to base its design off of [Alessandro Warth](http://www.cs.ucla.edu/~awarth/)'s JavaScript implementation of [OMeta/JS](http://jarrett.cs.ucla.edu/ometa-js/). This post gets into the specifics of how I've done this so far, but my hope is that you might see some places where the design could use improvement and that you might be encouraged to leave a comment so that it could get better.

## High Level Design

At its core, OMeta has a very simple design. The highest level of abstraction is a grammar. Here is a calculator grammar in the current implementation of OMeta#:

<pre  style="font-family:consolas, courier new, courier, monospace;"><span style="color:#0000ff;">ometa</span> <span style="color:#2b91af;">Calculator</span> <: <span style="color:#2b91af;">Parser</span> {<br />  Digit    = Super((Digit)):d         -> { d.ToDigit() },<br />  Number   = Number:n Digit:d         -> { n.As&lt;<span style="color:#0000ff;">int</span>&gt;() * 10 + d.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            Digit,<br />  AddExpr  = AddExpr:x '+' MulExpr:y  -&gt; { x.As&lt;<span style="color:#0000ff;">int</span>&gt;() + y.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            AddExpr:x '-' MulExpr:y  -&gt; { x.As&lt;<span style="color:#0000ff;">int</span>&gt;() - y.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            MulExpr,<br />  MulExpr  = MulExpr:x '*' PrimExpr:y -&gt; { x.As&lt;<span style="color:#0000ff;">int</span>&gt;() * y.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            MulExpr:x '/' PrimExpr:y -&gt; { x.As&lt;<span style="color:#0000ff;">int</span>&gt;() / y.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            PrimExpr,<br />  PrimExpr = '(' Expr:x ')'           -&gt; { x }<br />            Number,<br />  Expr     = AddExpr<br />} </pre>

A grammar is composed of rules (which are sometimes referred to as "productions"). Both the grammar itself and the rules have the same form:

![](/assets/building-object-oriented-parasitic/ruleapplication.png)

Going into the rule is a list of things of the *input* type (here they're represented by red circles) and coming out on the right is a list of things of the *destination* type (represented by purple triangles). As you can see from the diagram, the output list can have lists inside of it. In the calculator grammar, the circles are individual characters and the output is a single integer.

## My "[Ad Hoc, Informally-Specified, Bug-Ridden, Slow Implementation of Half of Common Lisp](http://en.wikipedia.org/wiki/Greenspun%27s_tenth_rule)"

As an implementer of OMeta, you have to make several design choices. One of the first is how to represent grammars. Since OMeta is object-oriented, I decided that it made sense to represent grammars as a .NET class (a.k.a. "[Type](http://msdn.microsoft.com/en-us/library/system.type.aspx)"). Grammars contain rules; the obvious choice for implementing rules is to use a [method](http://msdn.microsoft.com/en-us/library/ms173114.aspx). This especially makes sense because rules can refer to rules in their base grammar. For example, the above calculator grammar has a rule called "Digit" which captures a single *numeric* digit. The "Digit" rule applies the "Digit" rule in its base grammar (Parser) that simply captures a digit *character*. It does this by applying the special "Super" rule which will use the base grammar to apply the rule that is specified by an argument. Since rules are implemented as methods and rules can "override" their definition from their base grammar, it made sense to make rule methods "[virtual](http://msdn.microsoft.com/en-us/library/aa645767(VS.90).aspx)."

Another important decision is how to represent data going into and out of a rule application. An easy choice is to represent the data in a [List&lt;T&gt;](http://msdn.microsoft.com/en-us/library/6sh2ey19.aspx). This works out well except for the small detail that lists can contain other lists. This nested list idea has been around for at least 50 years in <a href="http://en.wikipedia.org/wiki/Lisp_(programming_language)">LISP</a> and languages derived from it (like <a href="http://en.wikipedia.org/wiki/Scheme_(programming_language)">Scheme</a>). Since it has worked out fairly well in those languages, I [stole](http://www.youtube.com/watch?v=J0UjU0rtavE) the idea of a LISP-like list in my [OMetaList&lt;TInput&gt;](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=264656&changeSetId=15493) class which is a list of other lists with a special case that makes lists of length 1 equivalent to the element itself.

These decisions get us started, but a problem comes up if you try to implement the [factorial](http://en.wikipedia.org/wiki/Factorial) function using recursion in an OMeta grammar:

<pre><span style="color:#0000ff;">ometa</span> <span style="color:#2b91af;">Factorial</span> {<br />    Fact 0                                               -&gt; { 1 },<br />    Fact :n ?(n.As&lt;<span style="color:#0000ff;">int</span>&gt;() &gt; 0) Fact((n.As&lt;<span style="color:#0000ff;">int</span>&gt;() - 1)):m -&gt; { n.As&lt;<span style="color:#0000ff;">int</span>&gt;() * m.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />} </pre>

If you look carefully at this grammar, you'll see that it only says two things:

1.  If the next element of input matches a 0, return 1
2.  If the next element of input is something greater than zero, store its value to "n" and then apply the "Fact" rule supplying it with the value of "n - 1" and capture that result to "m". Finally, return "n * m".

What might not be obvious at first is that any time you store something to a variable using an expression like ":n", the value stored must be of the destination type (e.g. a triangle in the diagram). This makes us need to update our mental model for how OMeta works. We need a place to store rule "arguments" which are already in the destination type.

One way of doing this is to create an argument stack that is separate from the rest of the input. Additionally, we'll need a place to store grammar-local variables as well as a place to remember previous results of rule applications for performance reasons. This gives us a much more complete picture of what really occurs:

![](/assets/building-object-oriented-parasitic/rullapplicationfromstack.png)

When a rule needs to consume input, it will first attempt to grab pop an item from the argument stack. If the stack is empty, then next element from the input list can be read.

I decided to store all of these details into a single class which I call an [OMetaStream&lt;TInput&gt;](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=264658&changeSetId=15493) which internally uses an [OMetaList&lt;TInput&gt;](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=264656&changeSetId=15493) for input data and an OMetaList&lt;[HostExpression](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=316963&changeSetId=15493)&gt; for storing the argument stack. The arguments are actually stored in an [OMetaProxyStream&lt;TInput&gt;](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=314607&changeSetId=15493) which inherits from [OMetaStream&lt;TInput&gt;](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=264658&changeSetId=15493), but this is just an implementation detail.

With the major data structures out of the way, one important choice remaining is how to handle going down the wrong path. If you look at the calculator grammar, you'll see that the "AddExpr" rule can be of the form "x + y", **or** "x - y", **or** a "MulExpr".

How does OMeta know which one to take? It makes a *prioritized choice* by trying each of the alternatives in the order specified. If it discovers that it has gone down the wrong path (e.g. the next item from the input is a "-" instead of a "+"), it needs to backtrack and reset itself to the condition it was in before the bad choice and then try the next option.

There are two obvious ways of doing this. The first approach is to leverage runtime support by using exceptions. This is exactly what OMeta/JS does. Using exceptions has an advantage of making the generated code simpler because there is no explicit code to "unwind the stack" in case you go down a bad path.

Although it makes the code easier to read, I decided against using exceptions and instead chose to use methods that return a boolean value to indicate if they succeeded. I did this for two important reasons:

1.  .NET does a bit of extra work when an exception is thrown (e.g. getting a stack trace). Therefore, throwing an exception has a non-trivial performance penalty.
2.  Rules have prioritized choice. This means that failing a single choice doesn't imply that the whole rule fails. Failing can be a very common occurrence (it's not *exceptional*) and this makes it very performance sensitive.

Here's a small glimpse of what the generated code looks like for attempting to apply the "AddExpr" rule:

<pre><span style="color:#2b91af;">OMetaList</span>&lt;<span style="color:#2b91af;">HostExpression</span>&gt; x;<br /><span style="color:#2b91af;">OMetaStream</span>&lt;<span style="color:#0000ff;">char</span>&gt; addExprOut;<br /><br /><span style="color:#0000ff;">if</span>(!MetaRules.Apply(AddExpr, inputStream2, <span style="color:#0000ff;">out</span> x, <span style="color:#0000ff;">out</span> addExprOut))<br />{<br />    <span style="color:#0000ff;">return</span> MetaRules.Fail(<span style="color:#0000ff;">out</span> result2, <span style="color:#0000ff;">out</span> modifiedStream2);<br />}</pre>

In this case, AddExpr is the name of the rule which is implemented as a method. Data is read from the "inputStream2" which is an OMetaStream (where the red circles are characters). The resulting list is saved to the "x" variable and the modified stream is stored in "addExprOut". In order to make back-tracking easier, OMetaStreams are mostly [immutable](http://en.wikipedia.org/wiki/Immutable_object), which means that they can't change. Instead of updating the stream itself, you get a fresh copy of the stream that contains what the result would be. If you need to back track, you can simply ignore the rule application output. As a side benefit, it makes it slightly easier to debug since you don't have to worry about the [mutations that could otherwise occur](http://www.moserware.com/2007/11/attack-of-mutations-or-why-we-do-we.html).

## Parasitic?

[<img src="/assets/building-object-oriented-parasitic/Female_Catolaccus_grandis_wasp_200.jpg" align="right">](http://en.wikipedia.org/wiki/Image:Female_Catolaccus_grandis_wasp.jpg)OMeta's [creator](http://www.cs.ucla.edu/~awarth/) [likes to refer to OMeta as a "parasitic language"](http://vpri.org/pipermail/ometa/2008-July/000051.html) because it doesn't exist on its own. It always lives on top of a "host language." This makes an implementation usually defined in terms of its host language. That's why there is "OMeta/**JS**" which uses JavaScript as a host language. Although my ultimate goal for OMeta# is to have the host language be any .NET language, I decided to use C# as my first host language.

One of the first issues that came up was trying to recognize what exactly is C# code. As you can see from examples in my [last post](http://www.moserware.com/2008/06/ometa-who-what-when-where-why.html), my first attempt was to pick a really ugly pattern that wouldn't occur in normal use. I picked two consecutive @ signs as in:

{% highlight c# %}
@@/*This is C#*/@@
{% endhighlight %}

It worked out well, but it had the downside that it was, well... *incredibly ugly*. I have since written [a rudimentary C# recognizer](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=328653&changeSetId=15493) written in OMeta# itself that is aware of strings and comments. The upside is that the syntax looks a little nicer:

{% highlight c# %}
{ /*This is C#*/ }
{% endhighlight %}

Using C# as the host language had several implications. The most challenging was working with C#'s static type system. This was both a blessing and a curse. On the one hand, I had to constantly think about where the data came from and where it was going. This forced me to actually understand the overall design better. On the other hand, I had to spend *so much time* thinking about it. Late-bound systems with dynamic typing such as Smalltalk and JavaScript remove the need for people to spend so much time doing this.

I'm optimistic that over time a lot of the stronger annoyances will go away. For example, the current syntax forces type identification as in:

<pre>-&gt; { n.As&lt;<span style="color:#0000ff;">int</span>&gt;() * 10 + d.As&lt;<span style="color:#0000ff;">int</span>&gt;() }</pre>

Where, OMeta/JS can just say:

<pre>-&gt; { n * 10 + d }</pre>

I'm not exactly sure how to do this yet. My initial guess is that I might be able to write some sort of [type inference](http://herbsutter.wordpress.com/2008/06/20/type-inference-vs-staticdynamic-typing/) algorithm (preferably written in OMeta#) that could do a reasonable job. My current ideas are tied too closely with the specific host language and would require a bit of work to port them to other host languages like Visual Basic. Another approach is to implement one or more helper classes that could enable [duck typing](http://en.wikipedia.org/wiki/Duck_typing) (e.g. if it looks like a certain type, walks like that type, and quacks like the type, it's *probably* that type).

Being able to have strong static typing internally while having a very clean syntax would be ideal (e.g. sort of like the C# 3.0 "[var](http://msdn.microsoft.com/en-us/library/bb383973.aspx)" keyword). Static typing is usually harder to achieve, but if you can do it well, you get many benefits. C# designer [Anders Hejlsberg](http://en.wikipedia.org/wiki/Anders_Hejlsberg) said it well in a [recent interview](http://www.se-radio.net/podcast/2008-05/episode-97-interview-anders-hejlsberg):

> "I don't see a lot of downsides to static typing other than the fact that it may not be practical to put in place, *and it is harder to put in place* and therefore takes longer for us to get there with static typing, but once you *do* have static typing. I mean, gosh, you know, like hey -- the compiler is going to report the errors *before* the space shuttle flies instead of whilst it's flying, that's a good thing!"

Another issue that came up was properly handling inheritance. It makes sense to use "virtual" methods for rules, but this also requires you to emit the "[override](http://msdn.microsoft.com/en-us/library/ebca9ah3.aspx)" directive to [avoid warnings](http://msdn.microsoft.com/en-us/library/04xcc4t1.aspx). [Another warning](http://msdn.microsoft.com/en-us/library/ms228459.aspx) cropped up from my use of the "[base](http://msdn.microsoft.com/en-us/library/hfw7t1ce.aspx)" keyword in the many delegates that makes it convenient from a code emission perspective, but frustrating from a verifiable security perspective. Both of these warning are being left for a latter phase.

Compiler issues were only one factor. The other significant piece was aesthetics. A notable number of rules yield specific lists as their result. C# doesn't [quite](http://msdn.microsoft.com/en-us/library/bb384062.aspx) have a good, clean way of expressing an OMetaList (that is, a list of lists). In order to get around this, I created the "[Sugar](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=328644&changeSetId=15493)" helper class which makes it slightly easier to write these lists. It's still far from perfect. Instead of having a nice way for expressing lists like that OMeta/JS:

`
-> ['add', x, y]
`

You have to do this instead:

`
-> { Sugar.Cons("add", x, y) }
`

This annoyance can probably be fixed by tricking the C# recognizer to act as if C# had a nice implicit way of expressing an OMetaList and then re-writing the expression to use the Sugar class.

Beyond C#, there is the "meta" "host language" which is the .NET [common language runtime](http://en.wikipedia.org/wiki/Common_Language_Runtime) itself. For code to play nice on it, it should abide by the .NET [framework design guidelines](http://blogs.msdn.com/kcwalina/archive/2008/04/09/FDGDigest.aspx) which dictate naming conventions and general practices. This had a parasitic effect in that it led me to name my rules after the naming guidelines for methods (e.g. they must be [PascalCased](http://c2.com/cgi/wiki?PascalCase)). Thus, in OMeta# there is the "**D**igit" rule instead of the "**d**igit" rule. OMeta/JS opts to prefix metarule method names with an underscore to make them not collide with other rules. I also wanted to hide metarules so that people would have to try harder to do the wrong thing; the best I could come up with to convey this idea was to implement them using an [explicit interface](http://msdn.microsoft.com/en-us/library/ms173157.aspx) exposed via a property (e.g. instead of "_apply", I have "MetaRules.Apply").

## Being a Contextual Packrat

The last intriguing thing about OMeta is exactly how it implements parsing. It uses a technique called a [Parsing Expression Grammar](http://en.wikipedia.org/wiki/Parsing_expression_grammar) (PEG) that [Bryan Ford](http://www.bford.info/) [introduced](http://www.bford.info/pub/lang/peg.pdf) in 2004. It's just a fancy way to say you support the following features: (The table comes from the OMeta [paper](http://www.cs.ucla.edu/~awarth/papers/dls07.pdf). I've also included how OMeta# implements them to prove its legitimacy):

<table cellspacing="0" cellpadding="2" border="1"><tbody><tr><td valign="top"><strong>expression</strong></td><td valign="top"><strong>meaning</strong></td><td valign="top"><strong>OMeta# Function</strong></td></tr><tr><td valign="top"><em>e</em><sub>1</sub> <em>e</em><sub>2</sub></td><td valign="top">sequencing</td><td valign="top">Seq</td><br /></tr><tr><td valign="top"><em>e</em><sub>1</sub> <em>e</em><sub>2</sub></td><td valign="top"><em>prioritized</em> choice</td><td valign="top">MetaRules.Or</td><br /></tr><tr><td valign="top"><em>e</em><sup>*</sup></td><td valign="top">zero or more repetitions</td><td valign="top">MetaRules.Many</td></tr><tr><td align="top"><em>e</em><sup>+</sup></td><td valign="top">one or more repetitions (not essential)</td><td valign="top">MetaRules.Many1</td></tr><tr><td valign="top">~<em>e</em></td><td valign="top">negation</td><td valign="top">MetaRules.Not</td></tr><tr><br /><td valign="top">&lt;<em>p</em>&gt;</td><td valign="top">production application</td><br /><td valign="top">MetaRules.Apply</td></tr><tr><td valign="top">'x'</td><td valign="top">matches the character x</td><td valign="top">Exactly</td></tr><br /></tbody></table>

The most interesting aspect to me is the prioritized choice. This is in contrast to "[Context-Free Grammar](http://en.wikipedia.org/wiki/Context-free_grammar)s" (CFGs) which are the traditional way of defining parsers. To highlight the difference, consider parsing this line of C/C++ code:

{% highlight c %}
if (condition1) if (condition2) Statement1(); else Statement2();
{% endhighlight %}

Is it the same as:

{% highlight c %}
if (condition1) { if (condition2) { Statement1(); } else { Statement2(); } }
{% endhighlight %}

... or is it:

{% highlight c %}
if (condition1) { if (condition2) { Statement1(); } } else { Statement2(); }
{% endhighlight %}

This is the classic "[dangling else](http://en.wikipedia.org/wiki/Dangling_else)" problem. Context Free Grammars usually have this problem because they are free of any context when they are parsing (surprise!). In these situations, you often have to rely on something besides the grammar itself to resolve these ambiguities. Parsing Expression Grammars don't have this type of problem because you specify explicitly which one to try first. The prioritized choice therefore avoids ambiguity.

In order to make the performance relatively in line with the size of the input, a technique of "[memoization](http://en.wikipedia.org/wiki/Memoization)" is used. This means the parser remembers what it has done previously; it does this as a [space-time tradeoff](http://en.wikipedia.org/wiki/Space-time_tradeoff). Keeping all those previous values have given them the reputation of being a "[packrat](http://pdos.csail.mit.edu/~baford/packrat/)" parser.

Let's say you have

<pre>  AddExpr  = AddExpr:x '+' MulExpr:y  -&gt; { x.As&lt;<span style="color:#0000ff;">int</span>&gt;() + y.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            AddExpr:x '-' MulExpr:y  -&gt; { x.As&lt;<span style="color:#0000ff;">int</span>&gt;() - y.As&lt;<span style="color:#0000ff;">int</span>&gt;() }<br />            MulExpr</pre>

and you try the first choice (AddExpr:x '+' MulExpr:y), but you get to where you're expecting a "+" and it isn't there. You'll notice that the second choice (AddExpr:x **'-'** MulExpr:y) repeats the first part (namely AddExpr:x). Instead of re-evaluating it, you can just retrieve the stored value that you remembered, or rather *memoized*.

Well, it's almost that simple. Note that the definition of an add expression (AddExpr) is [left-recursive](http://en.wikipedia.org/wiki/Left_recursion). This means that the left side is defined in terms of itself. A naïve implementation of the parser would try to evaluate "AddExpr" by applying the first choice which started with a AddExpr which would then cause it to try to apply AddExpr again and eventually cause a [stack overflow](http://en.wikipedia.org/wiki/Stack_overflow).

It's not a trivial problem to fix. In fact, the paper that introduced Parsing Expression Grammars said that left-recursion should be avoided since you can rewrite the rule to avoid left-recursion. This is unfortunate guidance because the rewritten rule sometimes loses the clarity that the left-recursive version of the rule had.

At the start of this year, a [paper](http://www.vpri.org/pdf/packrat_TR-2007-002.pdf) came out showing a very clever trick that makes left recursion possible.

Say that we're parsing the expression "1+2+3" using the "AddExpr." At the start of the expression we look at our memoization table to see if we have a precomputed value for "AddExpr". Since it is our first time, we won't find anything. The first part of the trick is to immediately store the result of "Fail" as the memoized result for AddExpr when starting at offset 0. We do this *before* we attempt to apply the rule.

When the parser uses recursion and finds itself again asking for the value of "AddExpr" at position 0, it *will* find a result of "fail" and thus fail that choice. It will then continue down to "MulExpr" where it will eventually match "1". The second part of the trick is to treat this value of "1" for "AddExpr" at position 0 as a "seed parse." The parser will then attempt to "grow the seed*"* by starting over at the beginning of the input stream, but this time it will remember its previous successful match. This will cause it to match "1+2" for AddExpr and then start over again by growing the seed to finally match "1+2+3."

In hindsight, it's a very simple idea. However, I say that only after some serious debugging time where I kept finding problems in my poor implementation. Alas, the entire algorithm is implemented in only a few lines of code in the "MetaRules.Apply" function in [OMetaBase.cs](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=264639&changeSetId=15493).

So there you have it, you now know all of the interesting ideas in OMeta#.

## Where is This Going?

OMeta# is a hobby project that's been a labor of love for me. You might have already guessed that if you noticed that [most check-ins](http://www.codeplex.com/ometasharp/SourceControl/ListDownloadableCommits.aspx) occur late at night or on the weekends. It's been slow, but it's coming together. Probably the most exciting highlight in the development came when I got enough of OMeta# working that I could rewrite parts of itself in OMeta#. This has the benefit of being cool from a meta self-reproducing level, but it's also a bonus because the code becomes much more readable and introspective. For example, compare the [C# recognizer that I wrote by hand](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=315537&changeSetId=15493) to the [OMeta# grammar version](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=328653&changeSetId=15493) that implements the same idea.

This approach of writing more of OMeta# *in* OMeta# will continue. It's my hope that as much as possible will be written in itself. A significant next step would be to rewrite the [code generator](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=264619&changeSetId=15493) as an OMeta# grammar. This isn't a new design idea. Each subsequent version of Smalltalk has been [bootstrapped](http://en.wikipedia.org/wiki/Bootstrapping_%28compilers%29) by its previous version.

I'll be the first to point out that there are a lot of rough edges to my current implementation. If you look around the [source code](http://www.codeplex.com/ometasharp/SourceControl/ListDownloadableCommits.aspx), you'll see several comments labeled "// HACK" where I admit a hacked version of an idea. One of the most glaring problems is that debugging is annoyingly difficult. I haven't yet implemented an optimizer for the generated code which causes a lot of unnecessary metarule applications. The second annoyance is that just stepping into so many methods that fail often takes a long time. Over time, I hope to add better hints to get more traditional error messages that you get from good compilers so that you don't have to step through the generated code to debug a grammar.

As mentioned earlier, the language recognizer could use some work to make the syntax cleaner as well inferring types so that grammar writers don't have to explicitly declare them. I have confidence that the work that would go into a good C# host language implementation would directly port to other languages such as Visual Basic.

There's also a great need cross pollination with other projects such as the [Dynamic Language Runtime](http://en.wikipedia.org/wiki/Dynamic_Language_Runtime) (DLR) which has already tackled some of the issues that OMeta# will face. Additionally, languages such as [F#](http://en.wikipedia.org/wiki/F_Sharp_programming_language) have similar data structures already built-in that OMeta uses. <a href="http://en.wikipedia.org/wiki/Boo_(programming_language)">Boo</a> and [Nemerle](http://en.wikipedia.org/wiki/Nemerle) have interesting extensibility points which could provide some good ideas. The problem for me is that there is so many different places to look. It'd be great if you know these languages (or others) and could tell me via a comment or better yet, by sending code of how they could help OMeta#.

As of right now, I plan on keeping the core functionality in C# rather than rewriting everything in another language or by using the DLR. The main reason is that C# is wide-spread in availability, both on .NET as well as on <a href="http://en.wikipedia.org/wiki/Mono_(software)">Mono</a>. A second reason is that I would like to keep the outside dependencies on OMeta# as small as possible.

OMeta is a beautiful in the same sense that mathematics can have a simple beauty. LISP has been referred to by some as "[The Most Important Idea in Computer Science](http://bc.tech.coop/blog/060224.html)" largely because its core ideas could be expressed on a half page of the [LISP 1.5 manual](http://www.softwarepreservation.org/projects/LISP/book/LISP%201.5%20Programmers%20Manual.pdf) (page 13 to be exact). This elegance is similar to mathematics of [Maxwell's Equations](http://en.wikipedia.org/wiki/Maxwell) describing electromagnetism.

It's my hope that I won't mess up the implementation to the point where this elegant beauty is lost. Currently it's way too ugly. I see some of the rough edges, but I'm sure you can help me discover others along with how to fix them. If this post sounds too complicated, it's not you, it's me. Let me know if something doesn't make sense and I'll try to provide clarification.

If you're interested in OMeta#, I highly encourage you to [download the latest version of the source code](http://www.codeplex.com/ometasharp/SourceControl/ListDownloadableCommits.aspx) [from CodePlex](http://www.codeplex.com/ometasharp/) and step through the [unit test runner](http://www.codeplex.com/ometasharp/SourceControl/FileView.aspx?itemId=309791&changeSetId=15493) to see things get built up.

If you can, keep notes of all the places where you see me doing something and let me know about them either through comments or via email. In addition, I also highly recommend experimenting Alessandro Warth's great [OMeta/JS](http://jarrett.cs.ucla.edu/ometa-js/) implementation via your web browser.

Happy OMeta-ing!