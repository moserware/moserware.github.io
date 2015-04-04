---
layout: post
title: "Notes from porting C# code to PHP"
date: 2010-10-26 08:34:00
updated: 2010-10-26 11:00:22
permalink: /2010/10/notes-from-porting-c-code-to-php.html
---
(**Summary**: I ported my TrueSkill implementation from [C#](http://github.com/moserware/Skills) to PHP and [posted it on GitHub](http://github.com/moserware/PHPSkills "Patches welcome :)"). It was my first real encounter with PHP and I learned a few things.)

I braced for the worst. [<img style="display: inline; margin-left: 15px; margin-right: 0px; border:0px" align="right" src="/assets/notes-from-porting-c-code-to-php/1000px-PHP-logo.svg_200.png">](http://php.net/download-logos.php)

After years of hearing [negative](http://www.codinghorror.com/blog/2008/05/php-sucks-but-it-doesnt-matter.html "Jeff Atwood's: 'PHP Sucks, But It Doesn't Matter.' Jeff has gone on record many times bemoaning the PHP language.") [things](http://stackoverflow.com/questions/309300/defend-php-convince-me-it-isnt-horrible "Stack Overflow Question: 'Defend PHP; convince me it isn't horrible'") about PHP, I had been led to believe that touching it would rot my brain. Ok, maybe that’s a *bit* much, but its [reputation](http://thisdeveloperslife.com/post/1270441885/1-0-5-homerun "In the 'Homerun' episode of 'This Developer's Life', David Heinemeier Hansson mentioned that one of the reasons why he switched to Ruby and created Rails was that he basically thought PHP (and Java) were beyond hope.") had me believe it was full of [bad problems](http://www.softwarebyrob.com/2006/11/17/single-important-rule-retaining-software-developers/ "To quote Paul Graham: 'Not every kind of hard is good. There is good pain and bad pain. You want the kind of pain you get from going running, not the kind you get from stepping on a nail. A difficult problem could be good for a designer, but a fickle client or unreliable materials would not be.' The basic idea is that bad problems just wear you out without giving you any benefit or insight."). Even the [cool kids](http://www.mailchimp.com/blog/ewww-you-use-php/#more-10515 "The guys at MailChimp recently wrote about how they're having some difficulties hiring programmers because their site is in PHP. This is probably indicative of a larger trend, especially among alpha geeks.") [had](http://news.ycombinator.com/item?id=1818954 "I think some of the general attitude can be summed up by this quote by pilif on Hacker News: 'While I really hate some aspects of PHP by now and I would love to have a Ruby or Python codebase to work with instead, rewriting all of this is out of the question.' which I can respect.") [issues](http://www.reddit.com/r/programming/comments/dutgs/ewww_you_use_php/ "Selected comment from skillet-thief on Reddit: 'PHP hinders you on a lot of levels: the community has such a wide range of skill levels, including a huge class of users who mostly know how to install and uninstall and reinstall until something works; code reuse is much harder than in other languages because there is a lot of bad code out there, the good code is packaged in a way that makes it hard to share (as a stand-alone tool a lot of times). Abstractions are generally harder to make too. There were no real anonymous functions until very recently.'") with PHP. But I thought that it couldn’t be too bad because there was [that one website](http://www.facebook.com/ "Formerly known as thefacebook") that gets a few hits using a [dialect of it](http://github.com/facebook/hiphop-php/wiki "I think that Zuckerberg's usage of PHP is similar to most people's in that it was easy to get started. Throw in lots of programmers and bam! You have a large codebase and a ship that's not feasible to rewrite. This probably justified the whole HipHop compiler rather than a rewrite. This is similar to FogBugz programmers using Wasabi to avoid rewriting VBScript code."). When [Kaggle](http://kaggle.com/) offered to sponsor a port of my [TrueSkill](http://www.moserware.com/2010/03/computing-your-skill.html) [C# code](http://github.com/moserware/Skills) to PHP, I thought I’d finally have my first real encounter with PHP.

## <?php echo "Disclaimer:"; ?>

To make the port quick, I kept most of the design and class structure from my C# implementation. This led to a less-than-optimal result since PHP really [isn’t object-oriented](http://michaelkimsal.com/blog/php-is-not-object-oriented/ "Yes, it has the 'class' keyword, but that was bolted on relatively late and wasn't the primary focus in PHP's design."). I didn’t do a deep dive on redesigning it in the native PHP way. I stuck with the philosophy that you can [write quasi-C# in any language](http://queue.acm.org/detail.cfm?id=1039535 "The classic phrase is: 'You can write Fortran in any language.' By not catering to PHP's strengths, I might have brought too much C#-ness to PHP without better factoring things."). Also, I didn’t use any of the web and database features that motivate most people to choose PHP in the first place. In other words, I didn’t cater to PHP’s [specialty](http://stackoverflow.com/questions/694246/how-is-php-done-the-right-way), so my reflections are probably an unfair and biased comparison as I was not using PHP the way it was intended. I [expect](http://www.lessonsoffailure.com/developers/language-flamewars-blub-paradox/) that I missed tons of great things about PHP.

Personal disclaimers aside, even PHP book authors don’t claim that it’s the nicest language. Instead, they highlight the language’s popularity. I sort of got the feeling that people mainly choose PHP in lieu of languages like C# because of its [current popularity](http://www.tiobe.com/index.php/paperinfo/tpci/PHP.html) and its perception of having a lower upfront cost, especially among cash-strapped startups. Matt Doyle, author of [Beginning PHP 5.3](http://www.amazon.com/gp/product/0470413964?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0470413964), wrote the following while comparing PHP to other languages:

> [<img align="right" border="0" src="/assets/notes-from-porting-c-code-to-php/BeginningPHPBookCover.jpg">](http://www.amazon.com/gp/product/0470413964?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0470413964 "Beginning PHP 5.3")![](http://www.assoc-amazon.com/e/ir?t=moserware-20&l=as2&o=1&a=0470413964)“Many would argue that C# is a nicer, better-organized language to program in than PHP, although C# is arguably harder to learn. Another advantage of ASP.NET is that C# is a compiled language, which generally means it runs faster than PHP’s interpreted scripts (although PHP compilers are available).” - p.5

He continued:

> “ASP and ASP.NET have a couple of other disadvantages compared to PHP. First of all, they have a commercial license, which can mean spending additional money on server software, and hosting is often more expensive as a result. Secondly, ASP and ASP.NET are fairly heavily tied to the Windows platform, whereas the other technologies in this list are much more cross-platform.” - p.5

Next, he hinted that Ruby might eventually replace PHP’s reign:

> “Like Python, Ruby is another general-purpose language that has gained a lot of traction with Web developers in recent years. This is largely due to the excellent Ruby on Rails application framework, which uses the Model-View-Controller (MVC) pattern, along with Ruby’s extensive object-oriented programming features, to make it easy to build a complete Web application very quickly. As with Python, Ruby is fast becoming a popular choice among Web developers, but for now, PHP is much more popular.” - p.6

and then elaborating on why PHP might be popular today:

> “[T]his middle ground partly explains the popularity of PHP. The fact that you don’t need to learn a framework or import tons of libraries to do basic Web tasks makes the language easy to learn and use. On the other hand, if you need the extra functionality of libraries and frameworks, they’re there for you.” - p.7

Fair enough. However, to really understand the language, I needed to dive in personally and experience it firsthand. I took notes during the dive about some of the things that stuck out.

## The [Good](http://www.amazon.com/gp/product/0596517742?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596517742 "This section title comes from the subtitle of my favorite JavaScript book") Parts

-   It’s relatively easy to learn and get started with PHP. As a C# developer, I was able to pick up PHP in a few hours after a brief overview of the syntax from [a book](http://www.amazon.com/gp/product/0470413964?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0470413964). Also, PHP has some decent [online help](http://php.net/manual/en/index.php). 
-   PHP is available on almost all web hosts these days at no extra charge (in contrast with ASP.NET hosting). I can’t emphasize this enough because it’s a reason why I would still consider writing a small website in it. 
-   I was pleasantly surprised to have unit test support with [PHPUnit](http://www.phpunit.de/). This made me feel at home and made it easier to develop and debug code. 
-   It’s very easy and reasonable to create a website in PHP using techniques like Model-View-Controller (MVC) designs that separate the view from the actual database model. The language doesn’t seem to pose any hindrance to this. 
-   PHP has a “[static](http://php.net/manual/en/language.oop5.static.php)” keyword that is sort of like a static version of a “this” reference. This was useful in creating a quasi-static “subclass” of my “[Range](http://github.com/moserware/PHPSkills/blob/master/Skills/Numerics/Range.php)” class for validating [player](http://github.com/moserware/PHPSkills/blob/master/Skills/PlayersRange.php) and [team](http://github.com/moserware/PHPSkills/blob/master/Skills/TeamsRange.php) sizes. This feature is formally known as [late static binding](http://en.wikipedia.org/wiki/Late_static_binding#Late_static).

## The “[When in Rome](http://en.wiktionary.org/wiki/when_in_Rome,_do_as_the_Romans_do "Si fueris Romae, Romano vivito more; Si fueris alibi, vivito sicut ibi.")...” Parts

-   Class names use PascalCase while functions tend to use lowerCamelCase like Java whereas C# tends to use PascalCase for both. In addition, .NET in general seems to have [more universally accepted naming conventions](http://www.moserware.com/2008/12/private-life-of-public-api.html) than PHP has. 
-   PHP variables have a ‘$’ prefix which makes variables stick out: 

{% highlight php %}
function increment($someNumber) 
{ 
    $result = $someNumber + 1; 
    return $result; 
}
{% endhighlight %}

This convention was probably copied from [Perl’s scalar variable sigil](http://en.wikipedia.org/wiki/Perl#Data_types). This makes sense because PHP [was originally](http://en.wikipedia.org/wiki/PHP#History) a set of Perl scripts intended to be a simpler Perl. 
-   You access class members and functions using an arrow operator (“->”) like C++ instead of the C#/Java dot notation (“.”). That is, in PHP you say 

{% highlight php %}
$someClass->someMethod()
{% endhighlight %}

instead of 

{% highlight c# %}
someClass.someMethod()
{% endhighlight %}

-   The arguments in a “[foreach](http://php.net/manual/en/control-structures.foreach.php)” statement are reversed from what C# uses. In PHP, you write: 

{% highlight php %}
foreach($allItems as $currentItem) { ... }
{% endhighlight %}

instead of the C# way: 

{% highlight c# %}
foreach(currentItem in allItems) { ... }
{% endhighlight %}

One advantage to the PHP way is its special syntax that makes iterating through key/value pairs in an map easier: 

{% highlight php %}
foreach($someArray as $key => $value) { ... }
{% endhighlight %}

vs. the C# way of something like this: 

{% highlight c# %}
foreach(var pair in someDictionary) 
{
    // use pair.Key and pair.Value 
}
{% endhighlight %}

-   The “=>” operator in PHP denotes a map entry as in 

{% highlight php %}
$numbers = array(1 => ‘one’, 2 => ‘two’, ...)
{% endhighlight %}

In C#, the arrow “=>” is instead used for a lightweight [lambda expression syntax](http://msdn.microsoft.com/en-us/library/bb308966.aspx#csharp3.0overview_topic7): 

{% highlight c# %}
x => x * x
{% endhighlight %}

To define the rough equivalent of the PHP array, you’d have to write this in C# 

{% highlight c# %}
var numbers = new Dictionary<int, string>{ {1, "one" }, {2, "two"} };
{% endhighlight %}

On the one hand, the PHP notations for maps is cleaner, but it comes at a cost of having no lightweight lambda syntax (more on that later). 

-   PHP has some “[magical methods](http://php.net/manual/en/language.oop5.magic.php)” such as “[\_\_construct](http://www.php.net/manual/en/language.oop5.decon.php#language.oop5.decon.constructor)” and “[\_\_toString](http://www.php.net/manual/en/language.oop5.magic.php#language.oop5.magic.tostring)” for the equivalent of C#’s [constructor](http://msdn.microsoft.com/en-us/library/ms173115.aspx) and [ToString](http://msdn.microsoft.com/en-us/library/system.object.tostring.aspx) functionality. I like C#’s approach here, but I’m biased.

## The “Ok, *I guess*” Parts

-   The free [NetBeans IDE for PHP](http://netbeans.org/features/php/index.html) is pretty [decent](http://stackoverflow.com/questions/6166/any-good-php-ide-preferably-free-or-cheap/6169#6169 "I first learned about NetBeans through the StackOverflow question 'Any good PHP IDE, preferably free or cheap?'") for writing PHP code. Using it in conjunction with PHP’s [XDebug](http://www.xdebug.org/) debugger functionality is a must. After my initial attempts at writing code with a [basic notepad](http://www.flos-freeware.ch/notepad2.html), I found NetBeans to be a very capable editor. My only real complaint with it is that I had some occasional cases where the editor would lock up and the debugger wouldn’t support things like watching variables. That said, it’s still good for being a free editor. 
-   By default, PHP passes function arguments by value instead of by reference like C# does it. This probably caused the [most](http://github.com/moserware/PHPSkills/commit/4c7cfef8d6c602e733f47965a59676080a81f860 "As you can tell by my many git commits, it took awhile to figure this out... and I still probably missed something.") [difficulty](http://github.com/moserware/PHPSkills/commit/803a0816a84879ebfa651ec975664c6ba2f7b93f) with the port. Complicating things further is that [PHP references are not like references in other languages](http://www.php.net/manual/en/language.references.return.php "They're more like symlinks on a filesystem than pointers"). For example, using references usually incurs a performance penalty since extra work is required. 
-   You [can’t](http://bugs.php.net/bug.php?id=47872) import types via namespaces alone like you can in C# (and Java for that matter). In PHP, you have to import each type manually: 

{% highlight php %}
use Moserware\Skills\FactorGraphs\ScheduleLoop; 
use Moserware\Skills\FactorGraphs\ScheduleSequence; 
use Moserware\Skills\FactorGraphs\ScheduleStep; 
use Moserware\Skills\FactorGraphs\Variable;
{% endhighlight %}

whereas in C# you can just say: 

{% highlight c# %}
using Moserware.Skills.FactorGraphs;
{% endhighlight %}

PHP’s way makes things explicit and I can see that viewpoint, but it was a bit of a surprising requirement given how PHP usually required less syntax. 
-   PHP lacks support for C#-like <a href="http://msdn.microsoft.com/en-us/library/512aeb7t(v=VS.100).aspx">generics</a>. On the one hand, I missed the generic type safety and performance benefits, but on the other hand it forced me to redesign some classes to not have an army of angle brackets (e.g. compare [this class in C#](http://github.com/moserware/Skills/blob/master/Skills/FactorGraphs/Factor.cs) to [its PHP equivalent](http://github.com/moserware/PHPSkills/blob/master/Skills/FactorGraphs/Factor.php)). -   You have to manually call your parent class’s constructor in PHP if you want that feature: 

{% highlight php %}
class BaseClass 
{ 
    function __construct() { ... } 
}

class DerivedClass extends BaseClass 
{ 
    function __construct() 
    { 
        // this line is optional, but if you omit it, the BaseClass constructor will *not* be called 
        parent::__construct(); 
    } 
}
{% endhighlight %}

This gives you more flexibility, but it doesn’t enforce C#-like assumptions that your parent class’s constructor was called. 
-   PHP doesn’t seem to have the concept of an implicit “$this” inside of a class. This forces you to always qualify class member variables with $this: 

{% highlight php %}
class SomeClass 
{ 
    private $_someLocalVariable; 
    function someMethod() 
    { 
        $someMethodVariable = $this->_someLocalVariable + 1; 
        ... 
    } 
}
{% endhighlight %}

I put this in the “OK” category because some C# developers [prefer](http://blogs.msdn.com/b/omars/archive/2004/02/05/67687.aspx) to always be explicit on specifying “this” as well. 
-   PHP allows you to specify the type of some (but not all kinds) of the arguments of a function: 

{% highlight php %}
function myFunction(SomeClass $someClass, array $someArray, $someString) 
{ 
    ... 
}
{% endhighlight %}

This is called “[type hinting](http://php.net/manual/en/language.oop5.typehinting.php).” It seems that it is designed for enforcing API contracts instead of general IDE help as it actually causes a [decrease in performance](http://stackoverflow.com/questions/3580628/is-type-hinting-helping-the-performance-of-php-scripts/3580660#3580660). 
-   PHP doesn’t have the concept of [LINQ](http://msdn.microsoft.com/en-us/netframework/aa904594.aspx), but it does support some similar functional-like concepts like [array\_map](http://php.net/manual/en/function.array-map.php) and [array_reduce](http://www.php.net/manual/en/function.array-reduce.php). 
-   PHP has support for [anonymous functions](http://php.net/manual/en/functions.anonymous.php) by using the "`function($arg1, ...){}`" syntax. This is sort of reminiscent of how C# did the same thing in version 2.0 where you had to type out “<a href="http://msdn.microsoft.com/en-us/library/0yw3tz5k(v=VS.100).aspx">delegate</a>.” C# 3.0 simplified this with a lighter weight version (e.g. “`x => x*x`”). I’ve found that this seemingly tiny change “isn’t about doing the same thing faster, it allows me to work in a [completely different manner](http://www.youtube.com/watch?v=4XpnKHJAok8#t=54m47s "The quote comes from Linus talking about how git's speed changes how you work. The full quote is: 'that is the kind of performance that changes how you work. It’s no longer doing the same thing faster, it’s allowing you to work in a completely different manner.'")” by employing functional concepts without thinking. It’s sort of a shame PHP didn’t elevate this concept with concise syntax. When C#’s lambda syntax was introduced in 3.0, it made me want to use them much more often. PHP’s lack of something similar is a strong discourager to the functional style and is a lesson that [C++ guys have recently learned](http://herbsutter.com/2010/10/07/c-and-beyond-session-lambdas-lambdas-everywhere/). 
-   Item 4 of [the PHP license](http://www.php.net/license/index.php#faq-lic) states:

> Products derived from this software may not be called “PHP”, nor may “PHP” appear in their name, without prior written permission from group@php.net. You may indicate that your software works in conjunction with PHP by saying “Foo for PHP” instead of calling it “PHP Foo” or “phpfoo”

This explains why you see carefully worded names like “[HipHop for PHP](http://developers.facebook.com/blog/post/358)” rather than something like “php2cpp.” This technically doesn’t stop you doesn’t stop you from having a project with the PHP name in it (e.g. [PHPUnit](http://www.phpunit.de/)) so long as the official PHP code is not included in it. However, it’s clear that the PHP group is trying to clean up its name from tarnished projects like [PHP-Nuke](http://en.wikipedia.org/wiki/PHP-Nuke). I understand their frustration, but this leads to an official preference for names like [Zope](http://www.zope.org/) and [Smarty](http://www.smarty.net/) that seem to be less clear on what the project actually does. This position would be like Microsoft declaring that you couldn’t use the “\#” suffix or the “Implementation Running On .Net ([Iron](http://stackoverflow.com/questions/1194309/why-are-many-ports-of-languages-to-net-prefixed-with-iron))” prefix in your project name (but maybe that would lead to more creativity?).

## The [Frustrating](http://www.joelonsoftware.com/uibook/chapters/fog0000000057.html "Like Joel mentions in this post from 2000, tiny frustrations add up to a really bad experience") Parts:

-   As someone who’s primarily worked with a statically typed language for the past 15 years, I prefer upfront compiler errors and warnings that C# offers and agree with [Anders Hejlsberg](http://en.wikipedia.org/wiki/Anders_Hejlsberg)’s [philosophy](http://www.se-radio.net/2008/05/episode-97-interview-anders-hejlsberg/ "The quote begins around 35:45"):

> “I think one of the reasons that languages like Ruby for example (or Python) are becoming popular is really in many ways in spite of the fact that they are not typed... but because of the fact that they [have] very good metaprogramming support. I don’t see a lot of downsides to static typing other than the fact that it may not be practical to put in place, and it *is* harder to put in place and therefore takes longer for us to get there with static typing, but once you do have static typing. I mean, gosh, you know, like hey -- the compiler is going to report the errors before the space shuttle flies instead of whilst it’s flying, that’s a good thing!”

But more dynamic languages like PHP have their supporters. For example, [Douglas Crockford](http://en.wikipedia.org/wiki/Douglas_Crockford) [raves](http://video.yahoo.com/watch/111596/1710658 "See video starting at the -18:14 mark") about JavaScript’s dynamic aspects:

> “I found over the years of working with JavaScript... I used to be of the religion that said ‘Yeah, absolutely brutally strong type systems. Figure it all out at compile time.’ I've now been converted to the other camp. I've found that the expressive power of JavaScript is so great. I've not found that I've lost anything in giving up the early protection [of statically compiled code]”

I still haven’t seen where Crockford is coming from given my recent work with PHP. Personally, I think that given C# 4.0’s optional support of [dynamic](http://msdn.microsoft.com/en-us/library/dd264736.aspx) objects, the lines between the two worlds are grayer and that with C# you get the best of both worlds, but I’m probably biased here.

-   You don’t have to define [variables](http://www.php.net/manual/en/language.variables.basics.php) in PHP. This reduces some coding “[ceremony](http://msdn.microsoft.com/en-us/magazine/dd419655.aspx "There's a lot of talk out there about ceremony vs essence.")” to get to the essence of your code, but I think it removes a [shock absorber/circuit-breaker](http://podcasts.pragprog.com/2007-10/michael-nygard-interview.mp3 "Quote is at 3:46 - 'We should have shock absorbers and circuit breakers so that [our systems] can be resilient to failure.'") that can be built into the language. This “feature” [turned my typo into a bug](http://github.com/moserware/PHPSkills/commit/fa10d276d6121f390b930b655a66edd9376e114e#L0L24) and led to a runtime error. Fortunately, options like [E_NOTICE](http://php.net/manual/en/errorfunc.configuration.php) can catch these, but it caught me off guard. Thankfully, NetBean’s auto-completion saved me from most of these types of errors. 
-   PHP has built-in support for associative arrays, but you [can’t use objects as keys](http://php.net/manual/en/language.types.array.php) or else you’ll get an “Illegal Offset Type” error. Because my C# API heavily relied on this ability and I didn’t want to redesign the structure, I [created my own hashmap](http://github.com/moserware/PHPSkills/blob/master/Skills/HashMap.php) that supports object keys. This omission tended to reinforce the belief that [PHP is not really object oriented](http://michaelkimsal.com/blog/php-is-not-object-oriented/). That said, I’m probably missing something and did it wrong. 
-   PHP [doesn’t support operator overloading](http://bugs.php.net/bug.php?id=9331&edit=1). This made my [GaussianDistribution](http://github.com/moserware/PHPSkills/blob/master/Skills/Numerics/GaussianDistribution.php) and [Matrix](http://github.com/moserware/PHPSkills/blob/master/Skills/Numerics/Matrix.php) classes a little harder to work with by having to invent explicit names for the operators. 
-   PHP lacks support for a C#-like <a href="http://msdn.microsoft.com/en-us/library/x9fsa0sw(v=VS.100).aspx">property syntax</a>. Having to write getters and setters made me feel like I was back programming in Java again. 
-   My code ran [slower in PHP](http://twitter.com/GregB/status/27244912213). To be fair, most of the performance problem was in [my horribly naive matrix implementation](http://github.com/moserware/PHPSkills/blob/master/Skills/Numerics/Matrix.php) which could be improved with a better implementation. Regardless, it seems that larger sites deal with PHP’s performance problem by writing critical parts in compiled languages [like C/C++](http://news.ycombinator.com/item?id=1820451) or by using caching layers such as [memcached](http://en.wikipedia.org/wiki/Memcached). One interesting observation is that the performance issue isn't really with the [Zend Engine](http://en.wikipedia.org/wiki/Zend_Engine) per-se but rather the semantics of the PHP language itself. Haiping Zhao on the HipHop for PHP team [gave a good overview of the issue](http://www.youtube.com/watch?v=p5S1K60mhQU#t=51m44s "From the Stanford lecture on HipHop for PHP"):

> “Around the time that we started the [HipHop for PHP] project, we absolutely looked into the Zend Engine. The first question you ask is 'The Zend Engine must be terribly implemented. That’s why it’s slow, right?' 

> So we looked into the Zend Engine and tried different places, we looked at the hash functions to see if it’s sufficient and look some of the profiles the Zend Engine has and different parts of the Zend Engine. 

> You finally realize that the Zend Engine is pretty compact. It just does what it promises. If you have that kind of semantics you just cannot avoid the dynamic function table, you cannot avoid the variable table, you just cannot avoid a lot of the things that they built... 

> that’s the point that [you realize] PHP can also be called C++Script because the syntax is so similar then you ask yourself, 'What is the difference between the speed of these two different languages and those are the items that are... different like the dynamic symbol lookup (it’s not present in C++), the weak typing is not present in C++, everything else is pretty much the same. The Zend Engine is very close to C implementation. The layer is very very thin. I don’t think we can blame the Zend Engine for the slowness PHP has.”

That said, I don’t think that performance alone would stop me from using PHP. It’s good enough for most things. Furthermore, I'm sure optimizers could use tricks like what the [DLR](http://en.wikipedia.org/wiki/Dynamic_Language_Runtime) and [V8](http://code.google.com/p/v8/) use to squeak out more performance. However, I think that in practice, there is a case of [diminishing returns](http://en.wikipedia.org/wiki/Amdahl's_law) where I/O (and not CPU time) typically become the limiting factor.

## Parting Thoughts

Despite my brief encounter, I feel that I learned quite a bit and feel comfortable around PHP code now. I think my quick ramp-up highlights a core value of PHP: its simplicity. I did miss C#-like compiler warnings and type safety, but maybe that’s my own personal acquired taste. Although PHP *does* have some [dubious features](http://www.reddit.com/r/programming/comments/dst56/today_i_learned_about_php_variable_variables/c12n0w9), it’s not nearly as bad as some people make it out to be. I think that its simplicity makes it a very respectable choice for the type of things it was originally designed to do like [web templates](http://wordpress.org/extend/themes/ "e.g. Wordpress ones"). Although I still wouldn’t pick PHP as my [first choice](http://weblogs.asp.net/scottgu/archive/tags/MVC/default.aspx) as a general purpose web programming language, I can now look at its features in a much more balanced way.

**P.S.** I’d love to hear suggestions on how to improve my implementation and learn where I did something wrong. Please feel free to use [my PHP TrueSkill code](http://github.com/moserware/PHPSkills) and submit [pull requests](http://help.github.com/pull-requests/). As always, feel free to fork the code and port it to another language like [Nate Parsons](http://github.com/nsp) did with his [JSkills Java port](http://github.com/nsp/JSkills).