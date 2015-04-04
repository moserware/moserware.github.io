---
layout: post
title: "Towards Moore's Law Software: Part 2 of 3"
date: 2008-04-15 07:11:00
updated: 2008-12-11 00:10:00
permalink: /2008/04/towards-moores-law-software-part-2-of-3.html
---
(**Note:** This is part two in a three part series. [Part one](http://www.moserware.com/2008/04/towards-moores-law-software-part-1-of-3.html) appeared yesterday.)

The end result of Charles Simonyi's abrupt departure from being with Microsoft for over 20 years is that he started his own company, [Intentional Software](http://intentsoft.com/). As a parting gift for uhm, you know, *leading the development of Word and Excel*, Microsoft let him use the patent for Intentional Programming that he created at Microsoft Research. The only minor stipulation was that he'd have to write his own code for it *from scratch*.

That really hasn't stopped him and his company. [Recently](http://intentsoft.com/technology/MIT_EmTech_Simonyi_Keynote_2007.pdf "recent keynote"), he discussed his company's "Intentional Domain Workbench" product that is built around these concepts. [One of his clients](http://www.capgemini.com/) is even using it to dramatically decrease the time it takes to develop software for pension plans and all its given rules. The working concept is that domain experts work in an environment and language that is highly tailored for them and the traditional programmers work on developing a generator that takes that language domain tailored code and makes it real executable code.

For example, an expert in banking will naturally think in terms of customers, accounts, credits, debits, loans, debt, and interest (among other ideas) and will not want to be bothered with anything resembling Java or XML. Having a highly customized tool allows the program to keep the domain model and programming implementation separated rather than having to "mentally unweave" the code to its parts, reason about it and then "reweave" the solution. It's the "repeated unweaving and reweaving... burden on the programmers that introduces many programming errors into the software and can increase costs disproportionate to the size of the problem."

So Simonyi's solution is that business folks are on one side of the fence and programmers on the other, but they happily work together by focusing on the parts they care about.

[Martin Fowler](http://martinfowler.com/) is another guy that I respect that has been advocating a similar idea of a "[Language Workbench](http://martinfowler.com/articles/languageWorkbench.html "Language Workbench")" where you can use tools to easily create new languages. The philosophy is that general languages don't let you think close enough to your problem to do things efficiently. Having such a workbench helps with a similar idea that is [picking up](http://www.oopsla.org/podcasts/Episode8_Domain_Specific_Modeling.mp3) [momentum](http://doi.acm.org/10.1145/1297846.1297867) now called [Domain Specific Modeling](http://en.wikipedia.org/wiki/Domain-Specific_Modeling) (DSM) that goes back [at least to the 1960](http://portal.acm.org/citation.cfm?doid=800198.806097)'s. In DSM, you typically use a [Domain Specific Language](http://en.wikipedia.org/wiki/Domain-specific_programming_language) (DSL) to model your exact organization rather than use a general programming language like C#.

Some products are getting away with having their own language. In college, I frequently used [Mathematica](http://www.wolfram.com/products/mathematica/index.html "Mathematica"). It has a custom language as the flagship [core of the product](http://reference.wolfram.com/mathematica/guide/LanguageOverview.html "core of their product"). Mathematica's vendor even makes it a selling point that Mathematica has an [extensive amount of its code](http://reference.wolfram.com/mathematica/tutorial/TheSoftwareEngineeringOfMathematica.html "extensive amount of its code") written in this special language because they think it's so good.

Frequently the programmers of complex programs have to do as Charles likes to do and "go meta." This allows you to create and add elements to a highly customized language. If you become skilled at this, you can [continually create more powerful constructs](http://www.paulgraham.com/icad.html) in the language to get things done faster. This is essentially the concept of "metaprogramming." [Giles Bowkett](http://gilesbowkett.blogspot.com/) [gave](http://mwrc2008.confreaks.com/03bowkett.html "Fast forward to 39:32") my favorite definition of it:

> "Skilled programmers can write better programmers than they can hire."

*That's* meta-programming.

## Building from the Ground Up

So what might software look like if you built it from the ground up using powerful meta-programming ideas? What if 1970's [Xerox PARC](http://en.wikipedia.org/wiki/Xerox_PARC) crew, which included Simonyi, was all [together again](http://unqualified-reservations.blogspot.com/2007/08/whats-wrong-with-cs-research.html) working on new ideas? One of the closest to this dream is the [Viewpoints Research Institute](http://www.vpri.org/) founded by [Alan Kay](http://www.vpri.org/html/people/founders.htm). Its research group has many former Xerox PARC researchers. I haven't been able to stop thinking about one of their projects that started out as an [NSF](http://www.nsf.gov/dir/index.jsp?org=CISE) [proposal](http://www.vpri.org/pdf/NSF_prop_RN-2006-002.pdf) with a very interesting title "**Steps Toward The Reinvention of Programming: A Compact And Practical Model of Personal Computing As A Self-Exploratorium**."

[<img style="MARGIN: 0px 0px 0px 20px" src="/assets/towards-moores-law-software-part-2-of-3/pyramid_320.jpg" align="right">](http://www.flickr.com/photos/lyng883/2168065634/ "Great Pyramid of Giza. Photo by Lyn G.") In [a video describing the project](http://irbseminars.intel-research.net/AlanKay.wmv), Alan makes some very intriguing observations. The first is that if you can get the system down to **20,000 lines of code for everything;** that is, the OS and applications - a “from the metal to the end-user” design, you're talking about at the **size of a 400 page book** which is well within grasp of a student. The system could be [introspective](http://en.wikipedia.org/wiki/Introspection) and essentially a "museum on itself."

Many other popular "systems" start with a small "kernel" that is very adaptive; a good example is the [U.S. Constitution](http://www.law.cornell.edu/constitution/constitution.overview.html) that fits comfortably in a shirt pocket and has served as an engine to keep our country thriving for 200+ years. One interesting comment he made that really stuck out was that modern software is typically designed by [accretion](http://www.answers.com/accretion&r=67), much like a pyramid.[<img style="MARGIN: 20px 20px 20px 0px" src="/assets/towards-moores-law-software-part-2-of-3/empirestatebuilding_320.jpg" align="left">](http://www.flickr.com/photos/global-jet/1312460212/ "Empire State Building as seen from the 70th floor of the Rockefeller Building. Photo by ") That is, [we design by adding around the edges](http://www.joelonsoftware.com/items/2008/02/19.html "The popular Microsoft Office binary file formats are a good example of this") rather than being willing to do a radical top to bottom design like the [Empire State Building](http://en.wikipedia.org/wiki/Empire_State_Building) which was built in about a year with great engineering precision. We keep adding to systems rather than look back at their core assumptions to see if they're still meeting our needs.

A key tenet of his discussion is that we've lost 15 years of programming progress because of bad architecture, which led to a lost factor of 1000 in efficiency. We're essentially drowning in all the code. A hundred million lines of code can't be studied or fundamentally improved.

> To "reduce the amount of code needed to make systems by a factor of 100, 1000, 10,000, or more," you have to do what they call "big things in very simple ways." This leads to where I got the title of this series: 
> 
> **"This enormous reduction of scale and effort would constitute a 'Moore’s Law' leap in software expressiveness of at least 3 and more like 4 orders of magnitude**. It would also illuminate programming and possible futures for programming. It might not be enough to reach all the way to a 'reinvention of programming', but it might take us far enough up the mountain to a new plateau that would allow the routes to the next qualitative change to be seen more clearly. This is the goal and mission of our project."

Wow! I couldn't help but be impressed by their ambition. After reading that statement, my mind began to dream for a few minutes what might possible if the expressiveness of programming languages and systems might double in capacity every two years just like the transistor count on microprocessors has almost doubled every two years leading to much more powerful chips.

That was my optimistic side, but then my mind was flooded with some <s>objections</s> *questions*...

## Intermission: Responding to [Critics](http://tomfishburne.typepad.com/tomfishburne/2008/02/the-8-types-of.html)

One thing that [Alan mentioned](http://irbseminars.intel-research.net/AlanKay.wmv "It's at the end of the video") is that the problems that we think are quite big are really much smaller if we could just think of them *mathematically*. [Being a person that enjoys mathematics](http://www.moserware.com/2007/12/how-legacy-of-dead-mathematician-can.html), I like the thought of making programming [a bit more mathematical](http://research.sun.com/projects/plrg/PLDITutorialSlides9Jun2006.pdf "For example, Guy Steele's 'Fortress' programming language lets you conceivably write code that looks like 'Σ[k=1:n] a[k] x^k'"). However, sometimes people interpret thinking mathematically as having overly terse syntax. Some languages like <a href="http://en.wikipedia.org/wiki/APL_(programming_language)">APL</a> are notorious for being terse and this has led quite a few people to [hate these languages](http://arcanesentiment.blogspot.com/2008/02/enough-apl-hate.html). Here's an example of a line from [J](http://en.wikipedia.org/wiki/J_programming_language), an APL derivative:

{% highlight apl %}
mysteryFunction=: +/ % #
{% endhighlight %}

I obscured the name to make it less obvious. Can *you* guess what it does?

It computes the average of a vector. To be fair, it probably seems obvious to those that use the language every day.

A less terse, but equally strange to outsiders, class of languages are ones like [Lisp](http://en.wikipedia.org/wiki/Lisp_programming_language) ([and Scheme](http://groups.google.com/group/comp.lang.lisp/msg/871b85e8a127ba1c "Like this link mentions, I'm not implying that they're similar from a semantic perspective. I'm just saying they look syntactically similar")). Here's an example of finding the length of a list:

{% highlight lisp %}
(define (len xs) 
(if (null? xs) 
0 
(+ 1 (len (cdr xs)))))
{% endhighlight %}

If you know the language you can easily see that this is **define**-ing a function called **len** that works on a list named **xs**. If **xs** is [null](http://en.wikipedia.org/wiki/Null), then return **0**, otherwise, remove one element from the list and then find the **len**gth of that [smaller list](http://en.wikipedia.org/wiki/Divide_and_conquer_algorithm) (**cdr xs**) and add one (**+ 1**) to it.

See? It's not too bad.

I say this sort of [toungue-in-cheek](http://en.wikipedia.org/wiki/Tongue-in-cheek) since it took me several weeks in my programming languages class to feel comfortable in the language. As an outsider coming from a BASIC or C++ derived language, it sort of looks like magic.

Speaking on how [Ruby](http://en.wikipedia.org/wiki/Ruby_programming_language)'s more readable syntax might be used to express Lisp's power in a clearer way, [Giles Bowkett](http://gilesbowkett.blogspot.com/) [said](http://mwrc2008.confreaks.com/03bowkett.html "at 38:50"):

> You've got on the one hand incredible power *wrapped up in parenthesis that no one else can read* -- **that makes you a wizard**; but if you take that same incredible power and you put it in terms that anybody can use it, [then] you're not making yourself a wizard, you're making everybody who looks at your code, reads your code, uses your code, ***everybody*** becomes more effective. Instead of hoarding this magical treasure and wrapping it in layers of mystery so that only you can use it, you're making it a public resource.

That sounds interesting, but I don't think that Lisp's syntax is really *that bad* or inaccessible. It seems a bit different than what I grew up with, but I'm pretty sure that if I was taught it as my first language, it'd probably feel even more natural. Surely if I can be taught that "[x = x + 1](http://www.moserware.com/2007/11/attack-of-mutations-or-why-we-do-we.html)" is not an insane oddity, then I can probably be taught anything.

But Lisp is more than syntax; it's arguably its own *culture*. One of its biggest supporters is [Paul Graham](http://www.paulgraham.com/), [who implies](http://www.paulgraham.com/icad.html) that you can get away with not using Lisp for "glue" programs, *like typical business applications*, but if you want to write "sophisticated programs to solve hard problems," like an [airline reservation system](http://www.franz.com/success/customer_apps/data_mining/itastory.php3), then [you'll end up spending more time and will write far more code](http://www.paulgraham.com/icad.html) using anything else but Lisp (or something very close to it).

I have a lot of respect for Graham and tend to [agree](http://www.paulgraham.com/disagree.html) with the core idea he has behind it. Tools like Java and C# are good, but we could do much better than how they're typically used. Furthermore, there tends to be [resistance](http://www.paulgraham.com/iflisp.html) for even thinking about [using any other language](http://www.joelonsoftware.com/items/2006/09/01.html) these days besides something like C#, Java, PHP, or Python.

## Brief Aside: What about the "Wasabi" Incident?

As we saw in [Part 1](http://www.moserware.com/2008/04/towards-moores-law-software-part-1-of-3.html), Charles' [Intentional Software](http://intentsoft.com/) was founded with the idea that companies should develop their own language to solve their particular business problem. This statement is given in the context that you will use Simonyi's company's tools to do that. But what if you took this [language oriented programming](http://en.wikipedia.org/wiki/Language-oriented_programming) idea and went about it in a seemingly less radical way. What if you just extended an existing language to meet your company's specific needs?

That's exactly what [Joel Spolsky](http://www.joelonsoftware.com/)'s [Fog Creek](http://www.fogcreek.com/) company [did](http://www.joelonsoftware.com/items/2006/09/01.html) for their [FogBugz](http://fogcreek.com/fogbugz/) product. They had written the application using ASP and VBScript targeting Windows based servers and then were faced with the strategic opportunity to also make it work on Linux using PHP. Instead of [rewriting](http://www.joelonsoftware.com/articles/fog0000000069.html) their code, Joel made an interesting decision to commission the development of an in-house compiler that would emit VBScript and PHP from the original source code. Once the compiler was working, they even made enhancements to the VBScript source language. They called this superset of VBScript '[Wasabi](http://www.fogcreek.com/FogBugz/blog/category/Wasabi.aspx).' Joel describes it as:

> ".. a very advanced, [functional-programming](http://en.wikipedia.org/wiki/Functional_programming) dialect of Basic with <a href="http://en.wikipedia.org/wiki/Closure_(computer_science)">closures</a> and [lambdas](http://en.wikipedia.org/wiki/Lambda_calculus) and [Rails](http://en.wikipedia.org/wiki/Ruby_on_Rails)-like [active records](http://en.wikipedia.org/wiki/Active_record_pattern) that can be compiled down to VBScript, JavaScript, PHP4 or PHP5. Wasabi is a private, in-house language written by one of our best developers that is optimized specifically for developing FogBugz; the Wasabi compiler itself is written in C#."

The mere thought of writing your own language, even if it was a superset of a standard language like VBScript shocked quite a few people. Many thought (and still think) that Joel had done something *really dumb*. It was an amusing time to read all the responses to it. One of the [most vocal was Jeff Atwood](http://www.codinghorror.com/blog/archives/000679.html):

> "However, *instead* of upgrading to ASP.NET, they decided to.. write their own proprietary language that compiles down to VBScript/PHP/JavaScript. 
> I just can't get behind that. It's a one-way ticket to crazytown. When was the last time you encountered a problem and thought to yourself, '**Mmm. What I really need here is MY VERY OWN PROGRAMMING LANGUAGE**.'"

and

> "My argument against Wasabi is this: when a developer decides the right solution to their problem is a new language, you don't have a solution. You have an even bigger problem."

So even extending a language sure does rock the boat. But I think that it's not as big of a deal as we think. Atwood later toned down a little bit saying that "[nobody cares what your code looks like](http://www.codinghorror.com/blog/archives/001022.html)." But regardless, it's a sentiment felt by a lot of people.

Why do they feel this way?

I don't fault Atwood, he's certainly entitled to his own views. Given the modern state of tools to support custom languages, it does seem a bit "crazy" to go down that path. You certainly have to [count the cost](http://www.biblegateway.com/passage/?search=Luke%2014:28;&version=47;) involved in creating a language or tool that's too "powerful."0 [Reg Braithwaite](http://weblog.raganwald.com/) [warns us about this](http://weblog.raganwald.com/2004/10/beware-of-turing-tar-pit.html "writes"):

> "What is the [Turing tar-pit](http://en.wikipedia.org/wiki/Turing_tarpit)? It’s the place where a program has become so powerful, so general, that the effort to configure it to solve a specific problem matches or exceeds the effort to start over and write a program that solves the specific problem.

I think one of the fundamental barriers is that our industry doesn't have more widespread knowledge of Martin Fowler's (amongst many others) ideas of a "[Language Workbench](http://martinfowler.com/articles/mpsAgree.html)" that can significantly ease the process.

Some companies are getting away with custom compilers that are similar to Wasabi. The [Google Web Toolkit](http://code.google.com/webtoolkit/) has a compiler that [converts code](http://code.google.com/webtoolkit/documentation/com.google.gwt.doc.DeveloperGuide.Fundamentals.html#JavaToJavaScriptCompiler "converts code") from Java to JavaScript. Maybe it didn't get the shocked response that Wasabi did because it didn't extend its source language, Java. I think that since many people [mistakenly believe](http://video.yahoo.com/watch/111593 "This is the best history of JavaScript I have found to date") that Java and JavaScript are similar, it didn't seem that radical.

## The Real Reason 'Very High Level Languages' Haven't Taken Off?

I hate to admit it, but one of the lures to writing in traditional languages is that the *brain power* per line of code is relatively low enough that it doesn't hurt too much to think in. When I was writing an [ML](http://en.wikipedia.org/wiki/ML_programming_language) compiler in ML, I had to think much harder for every line of code. It wouldn't be uncommon for me to spend 30 minutes on a single line. However, one of the benefits was that once I had written that line, it usually made sense. An advantage to this approach is that I wasn't *too* disturbed that [Standard ML](http://en.wikipedia.org/wiki/Standard_ML) didn't have a debugger at the time. It didn't really need one.

I think a part of the problem is that traditional languages make us feel that we're productive because we can generate lots of code quickly in them. But is this a good thing? [Erik Meijer](http://research.microsoft.com/~emeijer/) [said it well](http://channel9.msdn.com/Showpost.aspx?postid=393025 "The comment is at 40:27"):

> "Do you want to get [your program] done, or do you want to get it right? ... We confuse productivity with getting it done quickly. We don't [account for] all the hours of debugging. We're doing the wrong accounting."

A truly productive language will help us write code that is *right the first time* without the need for a lot of debugging. When you do honest accounting of the whole development cycle, I can then agree with [Fred Brooks](http://en.wikipedia.org/wiki/The_Mythical_Man-Month) [and others](http://www.paulgraham.com/power.html) that the number of lines of code written per day is approximately equivalent for a good programmer regardless of the language used. The real trick is how much you *do* in those lines.

Enough criticism. If the "Moore's Law" language of the future isn't necessarily APL, J, or excessive use of parenthesis, then what on Earth *might* it look like?

Let's take a peek.

**UPDATE**: [Part three](http://www.moserware.com/2008/04/towards-moores-law-software-part-3-of-3.html) is now available.