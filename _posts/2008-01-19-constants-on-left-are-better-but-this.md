---
layout: post
title: "Constants on the left are better, but this is often trumped by a preference for English word order."
date: 2008-01-19 17:30:00
updated: 2008-12-11 00:10:28
permalink: /2008/01/constants-on-left-are-better-but-this.html
---
Typically we all write comparison statements like this:

{% highlight c# %}
if (currentValue == 5)
{
    // do work
}
{% endhighlight %}

But, the following is just as valid:

{% highlight c# %}
if (5 == currentValue)
{
    // do work
}
{% endhighlight %}

The bottom style is a bit safer in languages like C because if you forget to put a double equals sign

{% highlight c %}
if (currentValue = 5)
{
    // do work
}
{% endhighlight %}

the compiler will assign 5 to the "currentValue" variable and the result will be the value of the assignment, which is 5. Anything that isn't zero is "truthy" and will cause the "if" branch to be taken. If you didn't intend for this and you're lucky enough to have compiler warnings turned all the way up, you'll get a helpful message like "**warning C4706: assignment within conditional expression.**"

Note that the bottom expression can never have this problem. The number 5 is constant and can not be assigned to, so you get a compile time error:

![](/assets/constants-on-left-are-better-but-this/ErrorLHSAssignment.png)

Therefore, getting in the habit of putting constants on the left hand side would have prevented the *possibility* the unintended assignment class of error.

Much less well known is that this type of thinking is also helpful when an "=" sign isn't present at all. Consider this function:

{% highlight c# %}
public static bool IsHelloWorld(string s)
{
    if (string.IsNullOrEmpty(s))
    {
        return false;
    }
    
    return s.Equals("Hello World", StringComparison.OrdinalIgnoreCase);
}
{% endhighlight %}

If you're a developer, you'll likely run into a lot of code just like this. Maybe the code you see won't check for bad input like they should, so you'll occasionally get a "NullReferenceException" which makes life no fun.

An astute observer would realize the code could be written:

{% highlight c# %}
public static bool IsHelloWorld(string s)
{
    return string.Equals(s, "Hello World", StringComparison.OrdinalIgnoreCase);
}
{% endhighlight %}

where the check for null is eliminated altogether and the *static* version of Equals is called. Since Equals does a null check internally, it'd be superfluous to do it twice.

This is usually where most people stop. Note that we could take advantage of constants on the left and do this:

{% highlight c# %}
public static bool IsHelloWorld(string s)
{
    return "Hello World".Equals(s, StringComparison.OrdinalIgnoreCase);
}
{% endhighlight %}

the result is that you save around 10 characters and still never throw a "NullReferenceException." This takes advantage of the fact that string literals are simply string objects themselves.

Again, putting the constant on the left eliminated the *possibility* of forgetting about nulls. But lets be honest, I don't do this in production code and you probably don't either.

Why not?

Well, it just *feels* wrong. Go ahead and look at any textbook you had in college or even the latest programming books and look at their code samples. While some of the more pragmatic ones for embedded systems might recommend putting integer constants on the left hand side, you'll almost never see the string example. I've only seen it [one book](http://codereviewbook.com/) myself.

But again, why?

I think the reason comes down to the fact that English sentences are almost always subject-verb-object where you say the subject noun before the object noun. When we write code, we probably unconsciously think something along the lines of "if this (subject) thingy (is equal to) this (object) thingy then do such and such." Just as saying "The program is what I wrote" is far and away weirder than saying "I wrote the program," putting constants on the left feels weird and I don't do it because I want my code to be as easy to read by others as possible.

Having subject-verb-object sentences is not the only way to express yourself. In the ["Koine" Greek](http://en.wikipedia.org/wiki/Koine_Greek) language that was spoken by most of the known world 2000 years ago, the subject and object could come in any order. The order you chose just let the reader know what you wanted to emphasize. The verb and nouns have endings on them (inflections/case) to let you know what each word means. Likewise, in Japanese you almost always do subject-object-verb. Word order is just one feature of a language, not some universal standard.

It makes me wonder how things like the [Sapir-Whorf hypothesis](http://en.wikipedia.org/wiki/Sapir-Whorf_hypothesis), which states that the language you think in *can* affect how you understand things and what type of thoughts you can have, might apply to the types of problems programmers face. However, I mean it in the opposite sense of the types of things your [programming language lets you do.](http://www.jdl.ac.cn/turing/pdf/p444-iverson.pdf) It's more of "what are the bad things that can be caused by how you do think."

In the end, I love the simplicity and terseness of putting constants on the left. However, the fact that English is the native language of almost everyone who looks at my code, and the overwhelming precedent of style has been to put constants on the right, I have no real choice but to put them on the right.

But I can't but wonder what would have happened had the Fortran or C specs been conceived in Greek or Japanese.