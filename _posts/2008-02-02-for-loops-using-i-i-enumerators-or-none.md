---
layout: post
title: "For Loops: Using i++, ++i, Enumerators, or None of the Above?"
date: 2008-02-02 17:00:00
updated: 2008-12-11 00:10:20
permalink: /2008/02/for-loops-using-i-i-enumerators-or-none.html
---
![An IBM 704 mainframe computer. (Image courtesy of Lawrence Livermore National Laboratory)](/assets/for-loops-using-i-i-enumerators-or-none/Ibm704.gif)



It was 1958; [IBM](http://en.wikipedia.org/wiki/Ibm) was the leader in creating computers that took up entire *rooms*. Their recent creation, the [IBM 704](http://en.wikipedia.org/wiki/IBM_704), was [projected to only sell six units](http://ed-thelen.org/comp-hist/amdahl-bio-core-1-4.html) and was priced accordingly. When it ended up selling well over 100 units, it helped propel the careers of its two lead designers. [Gene Amdahl](http://en.wikipedia.org/wiki/Gene_Amdahl), from whom we get [Amdahl's Law](http://en.wikipedia.org/wiki/Amdahl) (which is *still* a [hot](http://www.devx.com/go-parallel/Article/36006) [topic](http://www.ddj.com/cpp/205900309)), led the hardware design. [John Backus](http://en.wikipedia.org/wiki/John_Backus), the *B* in [BNF](http://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form), was responsible for leading a team to define and develop an implementation of [Fortran](http://en.wikipedia.org/wiki/Fortran_programming_language) that would help ease programming on the system. It offered a choice besides writing in the 704's assembly language.

[<img alt="A for loop in flow-chart notation (Image by Paweł Zdziarski)" src="/assets/for-loops-using-i-i-enumerators-or-none/For-loop-diagram_320.png" align="left">](http://en.wikipedia.org/wiki/Image:For-loop-diagram.png)

One of the newest features of their design was what would later be referred to as the "[for loop](http://en.wikipedia.org/wiki/For_loop)." I say "later," because at the time of its introduction, it was really a "do loop" in syntax, but it had the modern day meaning of a for loop.

As a programmer, you'd sit down at a typewriter-like device called a [keypunch](http://en.wikipedia.org/wiki/Keypunch), and would type out a line like "[310 DO 400 I=1,50](http://www.cs.rit.edu/~jsk4445/fortran.pps "For a picture of this actual statement on a punch card, check out slide 3 of this presentation.")" that would tell the compiler that "starting at line 310, keep executing code until you get to line 400, then increment the 'I' variable and start all over until 'I' exceeds 50, then stop by jumping to the line right after 400."

There are several things to note about that last statement. The first is that the idea of a "for loop" is over 50 years old. The second is that since there were only [72 characters of usable space](http://en.wikipedia.org/wiki/Computer_programming_in_the_punch_card_era) on the 704's card reader, the syntax had to be incredibly terse. Due to the design of language, "I" [was the first integer variable available](http://www.cs.virginia.edu/~asb/teaching/cs415-fall05/slides/03-fortran.doc) for use ("N" was the last, all others were floating point). Like it or not, this is probably the driving reason why you were taught to write statements like "for(int *i* = 0; *i* < 50; *i*++)" It's only convenient that "I" is also the first letter in "index" and "iterator." Computer programming teachers and books inevitably all trace back to Fortran.

I'm sure that as a programmer you've written thousands of for loops in your life. If you're a professional programmer, you've probably *read* thousands of for loops written by other people. If you do this long enough, you'll likely come across several different styles.

The first style is by far the most popular. We can illustrate it by an example. Let's say that we have a list of presidents of the United States and we want to know how many presidents have a last name that is longer than six letters. You might have a program that has a helper class like this:

![](/assets/for-loops-using-i-i-enumerators-or-none/presidentclass.png)

You'd then create and initialize a list of Presidents explicitly or from a file/database:

![](/assets/for-loops-using-i-i-enumerators-or-none/initpresidentslist.png)

Finally, you'd be able to have your dear friend, the for loop:

![](/assets/for-loops-using-i-i-enumerators-or-none/ippforloop.png)

We've all written code like this. It's so easy you don't even have to [think about it](http://www.joelonsoftware.com/articles/GuerrillaInterviewing3.html).

*Right*? Well, let's think about it just for fun.

The second style would be to do something like this:

![](/assets/for-loops-using-i-i-enumerators-or-none/ppiforloop.png)

Did you catch the difference? The first style used the post-[increment](http://msdn2.microsoft.com/en-us/library/36x43w8w.aspx) (i++) [operator](http://msdn2.microsoft.com/en-us/library/ms173145.aspx) for the [for-iterator](http://msdn2.microsoft.com/en-us/library/aa664753(VS.71).aspx) and the latter one used the pre-increment (++i) operator. Most of the world uses the post-increment notation because that's what we all saw in our textbooks and online samples. People that use the second notation are usually very particular about it. Almost all of them come from a C++ background. The reason is that in the [Standard Template Library](http://en.wikipedia.org/wiki/Standard_Template_Library) (the C++ rough equivalent of the .net [Base Class Library](http://en.wikipedia.org/wiki/Base_Class_Library)) has the concept of [iterators](http://www.sgi.com/tech/stl/Iterators.html) that allow you to go through a data structure like a [vector](http://www.sgi.com/tech/stl/Vector.html). In the implementation of the post-increment operator on the iterator, one needs to preserve a copy of the old value *and then* increment the value and return the *old* value to keep with the proper meaning of the operator in language specification. The post-increment operator is usually [implemented by calling the pre-increment operator](http://books.google.com/books?id=mT7E5gDuW_4C&pg=PA19&lpg=PA19&dq=%22pre+increment%22+%22post+increment%22&source=web&ots=AXSQA_kPnZ&sig=fyCGNqc1PMqZGo7akpIHImxtRbY) with the added tax of keeping the old value. Typically users of the "++i" style will come back at you and say something like "i++ is *so wasteful*! You've got that copy that you *aren't even using*! Shame on you buddy!"

Ok, maybe that's a *bit* extreme. But it could happen.

But, let's check out the truth for .net code. In this particular situation, is it wasteful? Let's look at the [IL](http://en.wikipedia.org/wiki/Common_Intermediate_Language) instructions for the post-increment (i++) version of our "for loop" using [ILDASM](http://technet.microsoft.com/en-us/library/f7dy01k1.aspx) (with my comments on the right):

![](/assets/for-loops-using-i-i-enumerators-or-none/forloopil.png)

Now, to save time, let's see how the above compares with the pre-increment (++i) version:

![](/assets/for-loops-using-i-i-enumerators-or-none/forloopilpre.png)

There you have it folks. The code is the *exact same* except for how the C# compiler *names* the throw-away variable used for checking inequalities. This has absolutely *no effect on performance*. All other instructions are exactly identical. The C# compiler sees that no one cares about preserving a copy of the value, and makes a decision to ignore that. This is so basic of a technique that this happens even in debug builds. In case you're wondering, we couldn't have just done a simple [diff](http://en.wikipedia.org/wiki/Diff) on the two EXEs even if the C# compiler emitted the same code because .net compilers place a Module Version Identifier ([MVID](http://books.google.com/books?id=oAcCRKd6EZgC&printsec=frontcover&dq=expert+.net+assembler&ei=9LqkR4KSFp-0iQGS4d2rCg&sig=OGqF9v-AOlPsjXVxbnPgjR_4SPQ#PPA115,M1)) [GUID](http://en.wikipedia.org/wiki/Globally_Unique_Identifier) that is different every time you compile your assembly.

Anyways, with all due respect, any C++ compiler worth its file size would perform the same optimization trick (for integer types). Like I said, the only real difference came with iterators. In .net, we don't have the exact equivalent of iterators, but we do have [Enumerator](http://msdn2.microsoft.com/en-us/library/78dfe2yb.aspx)s. This allows us to change the code above to look like this:

![](/assets/for-loops-using-i-i-enumerators-or-none/foreachloop.png)

Notice that we got rid of "i" completely! However, it's just slightly less efficient from a performance perspective. The reason is that the compiler turns this into a call to the List's [GetEnumerator](http://msdn2.microsoft.com/en-us/library/b0yss765.aspx)() which in turn does this:

![](/assets/for-loops-using-i-i-enumerators-or-none/listgetenumerator.png)

Which just punts to this method:

![](/assets/for-loops-using-i-i-enumerators-or-none/ilistenumeratorconstructor.png)

Now, during the actual enumeration/iteration, the code will call [MoveNext](http://msdn2.microsoft.com/en-us/library/system.collections.ienumerator.movenext.aspx)() that looks like this:

![](/assets/for-loops-using-i-i-enumerators-or-none/movenext.png)

There are two things that I found interesting. The first is that there is a check on a "_version" field to see if it's different and if so, throw an error. After doing some [reflectoring](http://www.aisto.com/roeder/dotnet/), it turns out that any time you modify a List through calls to methods like [Add](http://msdn2.microsoft.com/en-us/library/3wcytfd1.aspx) or [Remove](http://msdn2.microsoft.com/en-us/library/cd666k3e.aspx), the ["_version" member gets incremented](http://blogs.msdn.com/brada/archive/2004/06/13/154866.aspx). This tells the class that it's been changed. If you changed the List after creating the Enumerator, you'll get this unfriendly error message:

![](/assets/for-loops-using-i-i-enumerators-or-none/collectionmodifiedexception.png)

This design is ultimately caused by the second interesting thing in the code above. If you look carefully, you'll see that the core of MoveNext is exactly the same as the "for loop" style mentioned earlier. We have a "this.index" variable that gets incremented on every call and then we check to make sure that the index is less than "list._size". If the List is modified, the "this.index" might not make sense, and therefore an exception needs to be thrown.

After all enumeration is done, there is a call to dispose the Enumerator. Therefore, the "foreach" syntax is roughly rewritten to this code by the compiler:

![](/assets/for-loops-using-i-i-enumerators-or-none/getenumeratorfull.png)

which just makes me even more thankful for the C# "foreach" [syntax sugar](http://en.wikipedia.org/wiki/Syntactic_sugar).

Clearly the "foreach" method takes more instructions and performs a [generation 0](http://msdn.microsoft.com/msdnmag/issues/1200/GCI2/) memory allocation and therefore is *slightly* slower than the "for loop" method. However, it's more readable and intuitive. It lets you focus on the problem at hand (enumerating) rather than having to worry about things like the size of the List or being explicit with incrementing an index.

Can we go even better than "foreach"? Absolutely!

I'm sure you've even seen "foreach" a lot in production code for the reasons I mentioned. However, it's very repetitive and boring to have explicitly tell the computer to go through the List looking for a match.

Some programmers might have noticed that List<T> has a [ForEach](http://msdn2.microsoft.com/en-us/library/bwabdf9z.aspx) method that executes a delegate on each item in the list. This allows you to write statements like this:

![](/assets/for-loops-using-i-i-enumerators-or-none/delegateforeachlong.png)

The messy delegate notation in C# 2.0 made this approach hardly more elegant.

With [lambda expressions](http://msdn2.microsoft.com/en-us/library/bb397687.aspx) and [type inference](http://msdn2.microsoft.com/en-us/library/ms364047(vs.80).aspx#cs3spec_topic2), we can rewrite the above statement as:

![](/assets/for-loops-using-i-i-enumerators-or-none/delegateforeachshorter.png)

This really didn't buy us too much. It's still a bit messy. The final solution would be to use the [LINQ](http://msdn2.microsoft.com/en-us/netframework/aa904594.aspx) [Count](http://msdn2.microsoft.com/en-us/library/bb535181.aspx) [extension method](http://msdn2.microsoft.com/en-us/library/ms364047(vs.80).aspx#cs3spec_topic3) to get code like this:

![](/assets/for-loops-using-i-i-enumerators-or-none/extensionmethodcount.png)

Now we've actually made some progress! We've compressed all of the work to one *clean* line of code.

That was a long journey! Congratulations if you made it this far. Was it worth the investment?

## Lessons Learned

1.  When you don't care about what the specific item offset/index number is, prefer a foreach since it's cleaner and not that much more expensive.
2.  Sometimes you can't use a foreach because you need to know index number (e.g. going through two lists of the same size at the same time). This might be a better candidate for the "classic" for loop. However, don't bother with using a pre-increment operator because it's not the way the vast majority of people does it and it doesn't buy you *any* performance improvement.
3.  If performance is absolutely critical, use a for loop as it avoids the Enumerator allocation. You'll note that the source code for the .net Base Class Library tends to avoid "foreach" because it has been aggressively optimized for performance. It has to sacrifice readability for performance because the BCL is used everywhere. However, it's likely that your code doesn't have that type of strict performance requirement. Therefore, favor readability.
4.  It is worth your time to look at the [LINQ extension methods](http://msdn2.microsoft.com/en-us/vcsharp/aa336746.aspx) like [Count](http://msdn2.microsoft.com/en-us/vcsharp/aa336747.aspx), [Sum](http://msdn2.microsoft.com/en-us/vcsharp/aa336747.aspx), [Min](http://msdn2.microsoft.com/en-us/vcsharp/aa336747.aspx), [Max](http://msdn2.microsoft.com/en-us/vcsharp/aa336747.aspx), [Where](http://msdn2.microsoft.com/en-us/vcsharp/aa336760.aspx), [OrderBy](http://msdn2.microsoft.com/en-us/vcsharp/aa336756.aspx), and [Reverse](http://msdn2.microsoft.com/en-us/vcsharp/aa336756.aspx). It's amazing how these can dramatically simplify 6-7 lines down to a single line.
5.  By using the new extension methods, you'll be able to quickly take advantage of upcoming technologies like [Parallel LINQ](http://msdn.microsoft.com/msdnmag/issues/07/10/PLINQ/default.aspx). Say you had a billion presidents and 4 cores. You'd just simply change your code to "presidents.AsParallel().Count(..)" and your code would scale automatically to all processors.
6.  In short, consider thinking outside of "for loops" prefer to think at a higher level. One day, you just might be able to honestly say that [you've written your last "for loop."](http://beautifulcode.oreillynet.com/2007/10/writing_your_last_forloop.php)

One last thing: as Backus was developing Fortran, [John McCarthy](http://en.wikipedia.org/wiki/John_McCarthy_%28computer_scientist%29) was developing [LISP](http://en.wikipedia.org/wiki/Lisp_%28programming_language%29). Although the two languages started at roughly the same time, they had [notably different design philosophies](http://www.paulgraham.com/icad.html). Fortran was designed with a bottom-up style that was slightly higher than the raw assembler, but it was *fast*. LISP was deeply entrenched in the symbolic world of [lambda calculus](http://en.wikipedia.org/wiki/Lambda_calculus). It was powerful, but slow at first. Many of LISP's ideas are *just now* entering into common practice with popular languages like <a href="http://en.wikipedia.org/wiki/Python_(programming_language)">Python</a>, <a href="http://en.wikipedia.org/wiki/Erlang_(programming_language)">Erlang</a>, [F#](http://en.wikipedia.org/wiki/F_Sharp_programming_language), and as we saw in the code above, [C# 3.0](http://msdn.microsoft.com/msdnmag/issues/07/06/CSharp30/default.aspx).

So it seems that in 1958, [two roads diverged in a wood](http://en.wikipedia.org/wiki/The_Road_Not_Taken) and LISP became the road less traveled by. At least now, *fifty years later*, our industry is starting to bridge those two paths. Maybe [Anders](http://en.wikipedia.org/wiki/Anders_Hejlsberg) is right saying that in 10 years, [it'll be hard to categorize languages](http://blogs.tedneward.com/2008/01/29/Highlights+Of+The+LangNET+Symposium+Day+One.aspx) like C# because they will have deeply incorporated both paths.

But I can't help but think what programming would be like now had *Fortran* become the road not taken.

**P.S.** In case you care, there are 23 presidents of the United States who have a last name longer than 6 letters.