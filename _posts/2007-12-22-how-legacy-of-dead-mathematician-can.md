---
layout: post
title: "How the legacy of a dead mathematician can make you a better programmer"
date: 2007-12-22 15:29:00
updated: 2008-12-11 00:10:29
permalink: /2007/12/how-legacy-of-dead-mathematician-can.html
---
When was the last time you were challenged by an *algorithm*? As professional programmers, we often spend our day tackling things like:

-   Ensuring all of our UI updates are on the UI thread via use of [InvokeRequired](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.invokerequired.aspx) along with [BeginInvoke](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.begininvoke.aspx) or [Invoke](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.invoke.aspx). 
-   Querying a database and making sure we *correctly* handle people named "[Robert'); DROP TABLE Students; --](http://xkcd.com/327/)" 
-   Making sure our [classes have responsibilities and colloborate](http://en.wikipedia.org/wiki/Class-Responsibility-Collaboration_card) nicely with others 
-   Avoiding locks: either [dead](http://en.wikipedia.org/wiki/Deadlock) or [alive](http://en.wikipedia.org/wiki/Livelock#Livelock) 
-   Making sure we don't go peeking around the contents of whatever is at [address zero](http://en.wikipedia.org/wiki/Null_pointer#The_null_pointer). Besides, doing that is always [segmentation's fault](http://en.wikipedia.org/wiki/Segmentation_fault), not ours. 
-   Thinking about [Cheshire Cats and pimpl-es](http://en.wikipedia.org/wiki/Opaque_pointer) 
-   Making sure our [binary searches aren't broken](http://googleresearch.blogspot.com/2006/06/extra-extra-read-all-about-it-nearly.html) 
-   etc..

The list goes on and on.

But again I ask, when was the last time you were challenged by an *algorithm*?

I remember when I was 13 and writing a program for my aunt to help her schedule appointments for people. I had to make sure that people weren't scheduled on holidays like Christmas. I was writing the program in BASIC and it required me to learn things like [Julian dates](http://en.wikipedia.org/wiki/Julian_day). Days like Christmas and the 4th of July were easy because they always fell on the same day each year. The first one to really give me problems was Thanksgiving. Every stinkin' year it was on a different date!

The solution baffled me at the time. I even made use of my access to this new thing called the "Internet" and [asked puzzle gurus there](http://groups.google.com/group/rec.puzzles/browse_thread/thread/4d9343e12c4655ef/cb797004a26d0292#cb797004a26d0292) for help. I believe later that day I went to [Old Country Buffet](http://www.oldcountrybuffet.com/) with my family and kept thinking about it. After loading up on food, we were walking back to our car and it hit me: "start with the first Thursday in December and subtract 7 days!!" I already had code that told me what day of the week a Julian date fell on, so this was easy. After realizing this wouldn't work for Thanksgiving 1995 which was two months away, I think I corrected it to find the first Thursday in November and then calculate the right number of days afterwards.

I'm sure you're laughing at my early struggles. It's probably "intuitively obvious to [you,] the most casual observer" what the right algorithm is, but for my 13 year old self, it was hard.

{% highlight c# %}
static DateTime Thanksgiving(int year)
{
    DateTime nov1 = new DateTime(year, 11, 1);
    int dayOffset = DayOfWeek.Thursday - nov1.DayOfWeek;
    
    if (dayOffset < 0)
    {
        return nov1.AddDays(7 * 4 + dayOffset);        
    }
    else
    {
        return nov1.AddDays(7 * 3 + dayOffset);
    }
}
{% endhighlight %}

In college, I especially remember being challenged by algorithm problems like figuring out [what words to suggest for a misspelled word](http://en.wikipedia.org/wiki/Levenshtein_distance). The algorithms were non-obvious and took time to figure out. However, in the end, I usually ended up growing in my understanding of computer science as a result of solving them and in the process added a few more tools to my algorithmic toolkit.

After graduating and entering "the real world," I rarely had to wrestle with an algorithm and instead focused on more tactical issues like the bullet points above. This always nagged at me; I felt as if I was somehow "rotting" in my computer science abilities. My thinking was that if I kept getting bogged down in the tactical, day-to-day stuff, I'd never be able to "[hit the high notes](http://www.joelonsoftware.com/articles/HighNotes.html)" as a developer. It's been this fear of skills rot that has pushed me to look into Lisp, Haskell, F#, Erlang, and other languages to avoid [The Blub Paradox](http://www.paulgraham.com/avg.html). It's what drives me to attempt to [attack code bloat](http://steve-yegge.blogspot.com/2007/12/codes-worst-enemy.html), read [modern papers](http://www.hpl.hp.com/techreports/) and [watch videos of people way smarter than myself](http://www.youtube.com/watch?v=nU8DcBF-qo4). It's what makes me think of books like [Code Complete](http://www.cc2e.com/), [Code Craft](http://nostarch.com/frameset.php?startat=codecraft), and [Framework Design Guidelines](http://www.amazon.com/Framework-Design-Guidelines-Conventions-Development/dp/0321246756) each time I write code.

<img src="/assets/how-legacy-of-dead-mathematician-can/180px-Leonhard_Euler_400.jpg" style="float: left; margin: 20px;">

And lately, it's what drove me to the legacy of a dead mathematician. I found [ProjectEuler.net](http://projecteuler.net/) last week. It is a website dedicated to problems that can be solved efficiently with a good algorithm that runs for less than a minute. It's in memory of the [master mathematician](http://books.google.com/books?id=x7p4tCPPuXoC&dq=euler+master+of+us+all&pg=PP1&ots=YlxjuurL9Q&sig=9774dSLvuI2mrHW60PgjpbAaJGE&hl=en&prev=http://www.google.com/search?q=euler+master+of+us+all&rls=com.microsoft:*:IE-SearchBox&ie=UTF-8&oe=UTF-8&sourceid=ie7&rlz=1I7GGLR&sa=X&oi=print&ct=title&cad=one-book-with-thumbnail), [Leonhard Euler](http://en.wikipedia.org/wiki/Leonhard_Euler), who loved to "tinker" with mathematics and algorithms. I'm sure he'd probably work at Google if he were alive today.

What I love about ProjectEuler is that while some of the problems are very challenging, they are at least *possible* for me to solve. I've seen way too many contests that just are no fun because they take [too long](http://icpcres.ecs.baylor.edu/onlinejudge/index.php) to solve or are just [too hard](http://www.unl.edu/amc/a-activities/a7-problems/putnamindex.shtml).

Some took me only a few seconds to figure out, some have taken me an hour, and some I still haven't been able to solve. The real fun part is that once you solve the problem, you are granted access to a forum where people discuss their solutions. It's there where I've been most humbled. I might have taken 40 lines of code to figure out something someone did in a few minutes using a one line program in [J](http://en.wikipedia.org/wiki/J_programming_language), a language that I had never even *heard of* before. Still others will do it in Haskell or Python in a couple lines of code. Some brave guy consistently writes his solution in x86 assembler.

My approach has been to use C# 3.0's new features whenever possible. I was thrilled to be able to solve problem [#19](http://projecteuler.net/index.php?section=problems&id=19) in 1 line using LINQ concepts. I also really had fun with [#56](http://projecteuler.net/index.php?section=problems&id=59), writing an algorithm to decode a secret message. Although the site looks heavy on math, it's more about thinking algorithmically and no problems require fancy math beyond what you would have learned by high school.

I'm not saying ProjectEuler.net is the only way to improve as a developer. I'm sure some folks have very busy schedules with kids and other activities that make it almost impossible to study anything outside of work. However, I've found tackling a ProjectEuler problem can easily be more fun than watching an average weeknight TV show or just surfing the web in general, but that's just me.

What do you do to [sharpen](http://www.hanselman.com/blog/SharpenTheSawForDevelopers.aspx) your *algorithm* saw? Are you registered on ProjectEuler? If so, what's your username? (Here's [my profile](http://projecteuler.net/index.php?section=profile&profile=21742)) I'd love to learn from you if you post your solutions on the forums. It could be fun to have a friendly competition.