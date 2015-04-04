---
layout: post
title: "Attack of the mutations, or why do we accept crazy statements like x=x+1?"
date: 2007-11-11 22:56:00
updated: 2007-12-15 14:50:46
permalink: /2007/11/attack-of-mutations-or-why-we-do-we.html
---
I'll never forget walking into a room one day in my days before learning algebra and seeing something like `2x + 4 = 10` and after thinking for a minute, proudly exclaiming: "*Finally, I figured out all this algebra stuff, X is just a fancy way of saying 3! I'm a genius!*"

Well, my hopes were dashed when my sister told me that the value of X changed depending on the problem. Gee, wouldn't it be nice if X really was always one value, like, say 3? In a math problem, this is the case. If the variables could change on a whim -- that'd be maddening! Or would it? Some of the first programs we write are like this:

{% highlight c# %}
static void Main()
{
    Console.Write("Value to compute factorial of: ");
    
    int n = int.Parse(Console.ReadLine());
    int x = 1;
    while (n > 1)
    {
        x = x * n--;
    }
    Console.WriteLine("Result: {0}", x);
}
{% endhighlight %}

But, if we think about the line `x = x * n` *mathematically*, we must first assume that x cannot be zero, and then conclude that n must be 1. But this clearly isn't the case. Something odd is going on! The fact of the matter is that our world is changing, or dare I say, *mutating.*

To be honest, I never really even thought this was weird until I was reminded of the situation while listening to a comment made by [Erik Meijer](http://research.microsoft.com/~emeijer/) [in a recent interview](http://channel9.msdn.com/Showpost.aspx?postid=352136). My acceptance of the situation is perhaps due to me learning BASIC before I really even knew what algebra was. I treated variables as magical buckets that stored things and this just made sense once I "got the hang of it."

But do programming languages fundamentally require people to temporarily forget the math way and reprogram their mind? By no means! Anyone who has used a functional language like <a href="http://en.wikipedia.org/wiki/Haskell_(programming_language)">Haskell</a> knows that there is another way. That is, if X is 3, it will always be 3. None of this `x = x + 1` nonsense.

Despicable? Restrictive? Hardly. While it might require you to think more from a math perspective, it's probably a good thing in the end. While putting a watch window up on `x` in the C# example would be of some interest to verify the algorithm as you kept seeing `x` change. Putting a watch window on `x` would be quite boring, sort of like [doing price checks at the "Everything's a Dollar" store](http://www.youtube.com/watch?v=rFVbJvHHgdg), since `x` *cannot* change. It'd be so boring, that having a watch window would be almost worthless. That's another way of saying, it's not needed.

No debugger required? Well, that's at least worth another look, right? How much time do you spend pressing F10 and F11 while watching yellow lines move and stopping on red dots?

Having assurance that things don't magically change underneath you also lets you break up a task into many pieces if there are no dependencies to worry about. In other words, no fear about stepping on someone's toes. Why, if you're smart about it, there's nothing stopping you from breaking things up into billions of little pieces and having tens or even hundreds of thousands of dancers moving freely without fear of their toes being harmed. [That sure would be powerful](http://labs.google.com/papers/mapreduce.html): less debugging time and being able to harness the power [80+ core chips that are coming](http://www.news.com/2100-1006_3-6119618.html).

These are just two reasons: unchanging (immutable) variables and beautiful support for concurrency are driving me to start to at least look at [F#](http://research.microsoft.com/fsharp/fsharp.aspx) and [Erlang](http://www.erlang.org/). This is true even given the fact that [clever solutions](http://msdn.microsoft.com/msdnmag/issues/07/10/Futures/default.aspx) for the imperative languages (e.g. C#) are going to come mainstream in a year or two.

Giving up something that I thought was fundamental to programming like changing a variable can actually lead to extra power. This isn't new, we've already seen what can happen when you "force" your programming train to stay on the smooth, but albeit restricted path of [Rails](http://www.rubyonrails.org/).