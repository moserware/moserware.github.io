---
layout: post
title: "Boy Scout Check-ins"
date: 2008-10-31 08:40:00
updated: 2008-10-31 13:51:35
permalink: /2008/10/boy-scout-check-ins.html
---
I missed the [Boy Scouts](http://www.scouting.org/) callout when I was kid. Perhaps that's why it took me 20 years to figure out [a knot](http://www.fieggen.com/shoelace/secureknot.htm) that keeps my shoes tied all day. My recent attempt at starting a campfire required a [propane](http://en.wikipedia.org/wiki/Propane) torch. Despite my shortcomings, I felt a connection to the Scouts while reading this:

> [<img style="border-width: 0px; margin: 0px 0px 0px 10px;" src="/assets/boy-scout-check-ins/boyscouts_320.jpg" alt="boyscouts" width="244" align="right" border="0" height="156">](http://www.flickr.com/photos/greenacre8/369218941/)It's not enough to write the code well. The code has to be *kept clean* over time. We've all seen code rot and degrade as time passes. So we must take an active role in preventing this degradation. 

>The [Boy Scouts of America](http://en.wikipedia.org/wiki/Boy_Scouts_of_America) have a simple rule that we can apply to our profession. 

>**[Leave the campground cleaner than you found it.](http://www.scouting.org/cubscouts/aboutcubscouts/history.aspx)** 

>If we all checked-in our code a little cleaner than when we checked it out, the code simply could not rot. The cleanup doesn't have to be something big. Change one variable name for the better, break up one function that's a little too large, eliminate one small bit of duplication, clean up one composite 'if' statement. 

>Can you imagine working on a project where the code *simply got better* as time passed? Do you believe that any other option is professional? Indeed, isn't continuous improvement an intrinsic part of professionalism? [[Clean Code](http://www.amazon.com/gp/product/0132350882?ie=UTF8&tag=moserware-20&link_code=as3&camp=211189&creative=373489&creativeASIN=0132350882), p14]

While reading this, I was reminded of another gem:

> Well-designed code *looks* obvious, but it probably took an awful lot of thought (and a lot of refactoring) to make it that simple. [[Code Craft](http://www.amazon.com/gp/product/1593271190?ie=UTF8&tag=moserware-20&link_code=as3&camp=211189&creative=373489&creativeASIN=1593271190), p247]

Both sound great, but they have a sort of "Don't forget to [floss](http://en.wikipedia.org/wiki/Dental_floss)" ring to them.

We've heard for years that [refactoring](http://www.refactoring.com/) helps improve code, but actually doing it can sometimes feel *too* daunting. It's just a fact that a lot of the code we deal with on a daily basis doesn't have enough test coverage, if there are any tests at all, to have us feel fully confident with many changes that we make to our code.

But a Scout wouldn't let the sad state of some parts of the code get him down. A Scout would always have his nose out for [stinky](http://www.codinghorror.com/blog/archives/000589.html) [code](http://c2.com/xp/CodeSmell.html) to clean up so that he could get a teeny bit of satisfaction knowing that he checked-in code that was better than when he checked it out.

This [isn't a new idea](http://www.derickbailey.com/2008/03/11/MicroRefactoringLeaveTheCampsiteCleanerThanYouFoundIt.aspx); it's just a matter of realizing how easy it is.

## Examples

There's a lot of low-hanging fruit in a typical code base. Over months of development, the top of a C# file might look like this:

{% highlight c# %}
using System.Linq;
using System;
using System.Collections.Generic;
using Moserware.IO;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Text;
using System.Threading;
{% endhighlight %}

This is a messy way to introduce your code. With [just a simple click](http://richardbushnell.net/index.php/2008/03/03/remove-and-sort-those-ugly-using-statements/) in Visual Studio, you can have it automatically remove clutter and sort things to get something nicer:

{% highlight c# %}
using System.Text.RegularExpressions;
using System.Threading;
using Moserware.IO;
{% endhighlight %}

For a three second time investment, you'll leave the file slightly better than you found it. With a [free add-in](http://code.msdn.microsoft.com/PowerCommands), you can do this for your *entire project* in about the same amount of time.

Different team members can often work in the same class and you'll end up with member variable declarations that identify each person's style:

{% highlight c# %}
public class CircularBuffer<T>
{
  T[] m_array;
  private object syncRoot = new object();
  private int _HeadIndex;
  private int m_TailIndex;
...
{% endhighlight %}

This can easily be [made consistent in few seconds](http://msdn.microsoft.com/en-us/library/ms379618.aspx#vs05_refac_topic8):

{% highlight c# %}
public class CircularBuffer<T>
{
  private T[] _Array;
  private int _HeadIndex;
  private int _TailIndex;
  private object _SyncRoot = new object();
...
{% endhighlight %}

Changing a line like this:

{% highlight c# %}
if((i >= minAmount) && (i <= maxAmount))
{% endhighlight %}

to use [number-line order](http://safari.oreilly.com/0735619670/ch19lev1sec1):

{% highlight c# %}
if((minAmount <= i) && (i <= maxAmount))
{% endhighlight %}

makes the code slightly more visual and easier to read.

[Introducing an explaining variable](http://www.refactoring.com/catalog/introduceExplainingVariable.html) can turn:

{% highlight c# %}
private static DateTime GetElectionDay(int year)
{
  DateTime startDate = new DateTime(year, 11, 1);
  // Get the first Tuesday following the first Monday
  if (startDate.DayOfWeek <= DayOfWeek.Monday)
  {
     // Current day of the week is before Tuesday
     return startDate.AddDays(DayOfWeek.Tuesday - startDate.DayOfWeek);
  }
  else
  {
     // Current day of the week is Tuesday or after
     return startDate.AddDays(7 - (startDate.DayOfWeek - DayOfWeek.Tuesday));
   }
}
{% endhighlight %}

into a slightly more maintainable version that doesn't need comments:

{% highlight c# %}
private static DateTime GetElectionDay(int year)
{
  DateTime nov1 = new DateTime(year, 11, 1);

  int daysUntilMonday;
  if (nov1.DayOfWeek < DayOfWeek.Tuesday)
  {
     daysUntilMonday = DayOfWeek.Monday - nov1.DayOfWeek;
  }
  else
  {        
     daysUntilMonday = 6 - (nov1.DayOfWeek - DayOfWeek.Tuesday);        
  }

  DateTime firstMonday = nov1.AddDays(daysUntilMonday);
  return firstMonday.AddDays(1);
}
{% endhighlight %}

Along these lines, I tend to agree with [Steve Yegge](http://steve-yegge.blogspot.com/)'s [observation](http://www.oreillynet.com/ruby/blog/2006/03/transformation.html):

> The [[Refactoring](http://www.amazon.com/gp/product/0201485672?ie=UTF8&tag=moserware-20&link_code=as3&camp=211189&creative=373489&creativeASIN=0201485672)] book next tells me: don’t comment my code. Insanity again! But once again, his explanation makes sense. I resolve to stop writing one-line comments, and to start making more descriptive function and parameter names.

By themselves, each of these refactorings almost seems *too simple*. But each leaves your code in a slightly better place than you found it thereby qualify as a "Boy Scout Check-In."

## Be Careful

We've probably all heard horror stories of some poor programmer who changed just "[one little character](http://en.wikipedia.org/wiki/Off-by-one_error)" of code and caused rockets to explode or billion dollar security [bugs](http://www.wired.com/software/coolapps/news/2005/11/69355?currentPage=all). My advice is to not let that be you. Write more tests and use [code reviews](http://en.wikipedia.org/wiki/Code_review) if that helps. Just don't let it be an excuse to not do *something*.

Boy Scout Check-ins should be short and measured in minutes for how long they take. Get in and out with slightly better code that fixed one small thing. Try hard not to fix a bug or add a feature while doing these small check-ins or you might face the wrath of your coworkers as Raymond Chen [points out](http://blogs.msdn.com/oldnewthing/archive/2008/10/30/9023340.aspx):

> Whatever your changes are, go nuts. All I ask is that you restrict them to "layout-only" check-ins. In other words, if you want to do some source code reformatting *and* change some code, please split it up into two check-ins, one that does the reformatting and the other that changes the code. 
>Otherwise, I end up staring at a diff of 1500 changed lines of source code, [1498 of which are just reformatting](http://blogs.msdn.com/oldnewthing/archive/2008/03/27/8338530.aspx), and 2 of which actually changed something. Finding those two lines is not fun.

## Avoid Cycles

One subtle thing to realize is that you don't want to get lost in an infinite loop with a coworker of mutually exclusive changes. This is easy since good people can disagree. For instance, compare:

> Use 'final' or 'const' when possible By declaring a variable to be *final* in Java or *const* in C++, you can prevent the variable from being assigned a value after it's initialized. The *final* and *const* keywords are useful for defining class constants, input-only parameters, and any local variables whose values are intended to remain unchanged after initialization. [[Code Complete 2](http://www.amazon.com/gp/product/0735619670?ie=UTF8&tag=moserware-20&link_code=as3&camp=211189&creative=373489&creativeASIN=0735619670), p243]

and

> I also deleted all the 'final' keywords in arguments and variable declarations. As far as I could tell, they added no real value but did add to the clutter. Eliminating 'final' flies in the face of some conventional wisdom. For example, Robert Simmons strongly recommends us to "... [spread final all over your code](http://books.google.com/books?id=awnmD1w4_T8C&pg=PA72&lpg=PA72&dq=robert+simmons+%22spread+final+all+over+your+code%22&source=web&ots=ZuLGos4Q5j&sig=MvXAFM0YMhmct2HEs895umrVy4g&hl=en&sa=X&oi=book_result&resnum=1&ct=result)." Clearly I disagree. I think there are a few good uses for 'final', such as the occasional 'final' constant, but otherwise the keyword adds little value and creates a lot of clutter. [[Clean Code](http://www.amazon.com/gp/product/0132350882?ie=UTF8&tag=moserware-20&link_code=as3&camp=211189&creative=373489&creativeASIN=0132350882), p276]

Don't get bogged down with someone else on adding and removing 'final' or 'readonly'. Just be consistent.

I'm embarrassed to admit that in my earlier days, I might have "cleaned" code like this:

{% highlight c# %}
string headerHtml = "<h1>" + headerText + "</h1>";
{% endhighlight %}

into

{% highlight c# %}
string headerHtml = String.Concat("<h1>", headerText, "</h1>");
{% endhighlight %}

or even worse:

{% highlight c# %}
StringBuilder sb = new StringBuilder();
sb.Append("<h1>");
sb.Append(headerText);
sb.Append("</h1>");
string headerHtml = sb.ToString();
{% endhighlight %}

In this first case, I thought I was brilliant because I knew about the [Concat](http://msdn.microsoft.com/en-us/library/a6d350wd.aspx) method and thought it'd give me faster code. This is not true because the C# compiler special cases string concatenation to automatically do this. The second example is painful because it's [uglier and slower](http://www.yoda.arachsys.com/csharp/stringbuilder.html) and it isn't building a string in a loop where [StringBuilder](http://msdn.microsoft.com/en-us/library/system.text.stringbuilder.aspx)s make a lot of sense.

After many dumb mistakes like this, I've finally decided that if I ever have a doubt on which option to use, I'll pick the more readable one:

> Write your code to be read. By humans. Easily. The compiler will be able to cope. [[Code Craft](http://www.amazon.com/gp/product/1593271190?ie=UTF8&tag=moserware-20&link_code=as3&camp=211189&creative=373489&creativeASIN=1593271190), p59]

## Coda

**[<img style="border-width: 0px; margin: 0px 10px 0px 0px;" alt="Smokey3" src="/assets/boy-scout-check-ins/Smokey3_320.jpg" width="171" align="left" border="0" height="244">](http://en.wikipedia.org/wiki/Image:Smokey3.jpg)**Boy Scout check-ins are [small steps](http://www.joelonsoftware.com/items/2007/06/07.html) that help fix the [broken windows](http://en.wikipedia.org/wiki/Fixing_Broken_Windows) that we all have in our code. When you look at your code, try to find at least *one* thing you can do to leave it better. Eventually it becomes a game where everyone benefits. These check-ins can often be a small reward for checking-in a large feature or fixing a nasty bug.

If you're pressed for time and can't make the change now or you want to save it for when you can make the change across all your code, make a note to yourself. I create empty change-lists in [my version control system](http://en.wikipedia.org/wiki/Perforce) for this purpose. This is also helpful if you find a bug and want to later [complained](http://www.fastcompany.com/magazine/06/writestuff.html?page=0%2C4) that [hand-washing](http://www.mayoclinic.com/health/hand-washing/HQ00407) took too long and "wasted" their precious time. We all have our own pressures that might cause us to think that we can neglect basic code hygiene. Over time, this snowballs into a mess that we've all had to deal with.

Only you can [make a difference](http://www.cedu.niu.edu/%7Efulmer/starfish.htm) in *your* code campground.