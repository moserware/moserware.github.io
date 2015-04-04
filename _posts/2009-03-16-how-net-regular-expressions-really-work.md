---
layout: post
title: "How .NET Regular Expressions Really Work"
date: 2009-03-16 07:47:00
updated: 2009-03-17 09:39:40
permalink: /2009/03/how-net-regular-expressions-really-work.html
---
Remember when you first tried to parse text?

My early BASIC programs were littered with `IF` statements that dissected strings using `LEFT$`, `RIGHT$`, `MID$`, `TRIM$`, and `UCASE$`. It took me hours to write a program that parsed a simple text file. Just trying to support whitespace and mixed casing was enough to drive me crazy.

Years later when I started programming in Java, I discovered the [StringTokenizer](http://java.sun.com/j2se/1.4.2/docs/api/java/util/StringTokenizer.html) class. I thought it was a huge leap forward. I no longer had to worry about whitespace. However, I still had to use functions like "substring" and "toUpperCase", but I thought that was as good as it could get.

And then one day I found [regular](http://www.regular-expressions.info/quickstart.html) [expressions](http://www.dijksterhuis.org/regular-expressions-in-csharp-the-basics/).

I almost cried when I realized that I could replace parsing code that took me hours to write with a simple regular expression. It still took me several years to become comfortable with [the syntax](http://www.addedbytes.com/cheat-sheets/regular-expressions-cheat-sheet/), but the learning curve was worth the power obtained.

And yet with all of this love, I still had this nagging suspicion that I was doing it wrong. After [reading Pragmatic Thinking and Learning](http://www.moserware.com/2009/01/wetware-refactorings.html), I was determined to try to imagine what life was like inside the code I wrote. But I just couldn't connect with a regular expression.

The last straw came recently when I was trying to help a [coworker](http://www.aaronlerch.com/blog/) craft a regex to properly handle name/value string pairs with escaped strings. In the end, our regex worked, but I felt that it was duct-taped together. I knew there was a better way.

[<img style="margin: 20px" src="/assets/how-net-regular-expressions-really-work/masteringregex_200.jpg" align="left">](http://www.amazon.com/gp/product/0596528124?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596528124) I picked up a copy of Jeffrey Friedl's book "[Mastering Regular Expressions](http://www.amazon.com/gp/product/0596528124?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596528124)" and couldn't put it down. In less than a week, I had flown through 400+ pages and had finally started to feel like I understood how regular expressions worked. I finally had a sense for what backtracking really meant and I had a better idea for how a regex could go [catastrophically](http://www.regular-expressions.info/catastrophic.html) out of control.

I had extremely high hopes for chapter 9 which covered the .NET regular expression "flavor." Since I work with .NET every day, I thought this would be the best chapter. I did learn a few things like how to properly use [RegexOptions.ExplicitCapture](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regexoptions.aspx), how to use the [special per-match replacement sequences](http://msdn.microsoft.com/en-us/library/ewy2t5e0.aspx) that [Regex.Replace](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regex.replace.aspx) offers, how to [save compiled regular expressions to a DLL](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regex.compiletoassembly.aspx), and how to [match balanced parentheses](http://weblogs.asp.net/whaggard/archive/2005/02/20/377025.aspx) -- a feat that's theoretically not possible with a regex. Despite learning all of this in the chapter, I still didn't feel that I could "connect" with the very .NET regular expression engine that I know and love.

To be fair, the vast benefit of the book comes from the first six chapters that deal with how regular expressions work *in general* since regex implementations share many ideas. The book laid a solid foundation, but I wanted more.

I wanted to stop all my hand-waving at regular expressions and actually understand how they *really* work.

I knew I wanted to drill into the code. Although tools like [Reflector](http://www.red-gate.com/products/reflector/) are amazing, I knew I wanted to see the actual code. It's fairly easy now to [step into the framework source code](http://weblogs.asp.net/scottgu/archive/2008/01/16/net-framework-library-source-code-now-available.aspx) in the debugger. Unlike [understanding the details of locking](http://www.moserware.com/2008/09/how-do-locks-lock.html), which had me dive into C++ and x86 assembly, it was refreshing to see that the .NET regular expression engine was written entirely in C#.

I decided to use a really simple regular expression and search string and then follow it from cradle to grave. If you'd like to follow along at home, I've [linked](https://web.archive.org/web/20090402061020id_/http://www.koders.com/csharp/fid7F5AE3CBB76E9E51E24DEA0DB54B86C173369E88.aspx) to relevant lines in the .NET regular expression source code.

My very simple regex consisted of looking for a basic URL:

{% highlight c# %}
string textToSearch = "Welcome to http://www.moserware.com/!";
string regexPattern = @"http://([^\s/]+)/?";
Match m = Regex.Match(textToSearch, regexPattern); 
Console.WriteLine("Full uri = '{0}'", m.Value);
Console.WriteLine("Host ='{0}'", m.Groups[1].Value);
{% endhighlight %}

Our journey begins at [Regex.Match](http://msdn.microsoft.com/en-us/library/0z2heewz.aspx) where we [checking an internal cache](https://web.archive.org/web/20090402061020id_/http://www.koders.com/csharp/fid7F5AE3CBB76E9E51E24DEA0DB54B86C173369E88.aspx#L113) of the [past 15](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regex.cachesize.aspx) regex values to see if there a match for:

    "0:ENU:http://([^\\s/]+)/?"

This is a compact representation of:

<pre><a href="http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regexoptions.aspx">RegexOptions</a> : <a href="http://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.threeletterwindowslanguagename.aspx">Culture</a> : Regex pattern</pre>

The regex doesn't find this in the cache, so it starts [scanning the pattern](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L224). Note that [out of respect for the authors](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L21), our regex pattern doesn't have any comments or whitespace in it:

{% highlight c# %}
// It would be nice to get rid of the comment modes, since the 
// ScanBlank() calls are just kind of duct-taped in.
{% endhighlight %}

We [start](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L265) creating an internal tree representation of the regex by [adding](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L1869) a multi-character (aka "[Multi](https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L83)") node to contain the "http://" part. Next, we see that the scanner made it to first real capture:

<pre>http://<span style="font-weight: bold">([^\s/]+)</span>/?</pre>

This capture contains a [character class](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx) that says that we don't want to match spaces or a forward slash. It is converted into an obscure five character string:

    "\x1\x2\x1\x2F\x30\x64"

Later we'll see why it had to all fit in one string, but for now we can use a [helpful comment](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L16) to decode each character:

| Offset | Hex Value | Meaning |
|--------|-----------|---------|
| 0      | 0x01      | The set should be negated |
| 1      | 0x02      | There are two characters in the character part of the set |
| 2      | 0x01      | There is one Unicode category |
| 3      | 0x2F      | Inclusive lower-bound of the character set. It's a '/' in Unicode | 
| 4      | 0x30      | Exclusive upper-bound of the character set. It's a '0' in Unicode |
| 5      | 0x64      | This is a magic number that means the "[Space](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L63)" category. |
 
Before I realized that this string had meaning, I was utterly confused.

As we continue scanning, we [find a '+' quantifier](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L373):

<pre>http://([^\\s/]<span style="font-size:180%; font-weight:bold;">+</span>)/?</pre>

This is noted as a [Oneloop](https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L71) node since it's a "loop" of what came before (e.g. the character class set). It has arguments of 1 and [Int32.MaxValue](http://msdn.microsoft.com/en-us/library/system.int32.maxvalue.aspx) to denote 1 or more matches. We see that the next character isn't a '?', so we can assert this is [not a lazy match](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L406) which means it's a [greedy](http://en.wikipedia.org/wiki/Regular_expression#Lazy_quantification) match.

The first [group is recorded](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L301) when we hit the ')' character. At the end of the pattern, we note a [One](https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L79) (character) node for the '/' and we see it's followed by a '[?](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L368)' which is just [another quantifier](https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L551), this time with a minimum of 0 and a maximum of 1.

All those nodes come together to give us this "[RegexTree](https://web.archive.org/web/20090429025846id_/http://www.koders.com/csharp/fidECC3E02EC33C0F92A3E24574A0673340C8A22B2C.aspx):"

![](/assets/how-net-regular-expressions-really-work/RegexParseTree.png)

We still need to [convert the tree to code](https://web.archive.org/web/20090402061020id_/http://www.koders.com/csharp/fid7F5AE3CBB76E9E51E24DEA0DB54B86C173369E88.aspx#L133) that the regular expression "machine" can execute later. The bulk of the work is done by an aptly named [RegexCodeFromRegexTree](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L223) function that has a decent [comment](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L212):

{% highlight c# %}
/*
 * The top level RegexCode generator. It does a depth-first walk 
 * through the tree and calls EmitFragment to emits code before 
 * and after each child of an interior node, and at each leaf. 
 * 
 * It runs two passes, first to count the size of the generated 
 * code, and second to generate the code. 
 * 
 * <CONSIDER>we need to time it against the alternative, which is 
 * to just generate the code and grow the array as we go.</CONSIDER>;
 */
{% endhighlight %}

I love the anonymous "CONSIDER" comment and would have had a similar reaction. Instead of using an [ArrayList](http://msdn.microsoft.com/en-us/library/system.collections.arraylist.aspx) or [List](http://msdn.microsoft.com/en-us/library/6sh2ey19.aspx)&lt;int&gt; to store the op codes, which can automatically resize as needed, the code diligently goes through the entire RegexTree [*twice*](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L248). The class is peppered with "[if(\_counting)](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L126)" expressions that just increase a counter by the size they will use in the next pass.

As predicted by the comment, the bulk of the work is done by the 250 line switch statement that makes up the [EmitFragment function](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L305). This function breaks up RegexTree "fragments" and converts them to a simpler [RegexCode](https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx). The first fragment is:

<pre>
EmitFragment(nodetype=<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L450">RegexNode.Capture | BeforeChild</a>, 
             node=[<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L113">RegexNode.Capture</a>, Group=0, Length=-1], 
             childIndex=0)</pre>

This is shorthand for emitting the RegexCode that should come before the children of the top level "[RegexNode.Capture](https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L113)" node that represents group 0 and that goes until the end of the string (e.g. has length -1). The last 0 means that it's the 0th child of the parent node (this is sort of meaningless since it has no parent). The subsequent calls walk the rest of the tree:

<pre>
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L321">RegexNode.Concatenate | BeforeChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L108">RegexNode.Concatenate</a>], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L522">RegexNode.Multi</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L83">RegexNode.Multi</a>, string="http://"], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L322">RegexNode.Concatenate | AfterChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L108">RegexNode.Concatenate</a>], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L321">RegexNode.Concatenate | BeforeChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L108">RegexNode.Concatenate</a>], childIndex=1)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L450">RegexNode.Capture | BeforeChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L113">RegexNode.Capture</a>, Group=1, -1], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L513">RegexNode.SetLoop</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L73">RegexNode.SetLoop</a>, min=1, max=Int32.MaxValue], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L454">RegexNode.Capture | AfterChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L113">RegexNode.Capture</a>, Group=1, Length=-1], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L322">RegexNode.Concatenate | AfterChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L108">RegexNode.Concatenate</a>], childIndex=1)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L321">RegexNode.Concatenate | BeforeChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L108">RegexNode.Concatenate</a>], childIndex=2)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L503">RegexNode.Oneloop</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L71">RegexNode.Oneloop</a>, min=0, max=1, character='/'], childIndex=0)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L322">RegexNode.Concatenate | AfterChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L108">RegexNode.Concatenate</a>], childIndex=2)
EmitFragment(<a href="https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L454">RegexNode.Capture | AfterChild</a>, [<a href="https://web.archive.org/web/20090401224614id_/http://www.koders.com/csharp/fid0C0231291E4A7914C135C0A730D5A85182F872EB.aspx#L113">RegexNode.Capture</a>, Group=0, Length=-1], childIndex=0)
</pre>

The reward for all this work is an integer array that describes the RegexCode "op codes" and their arguments. You can see that some instructions like "[Setrep](https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L43)" take a string argument. These arguments point to offsets in a string table. This is why it was critical to pack everything about a set into the obscure string we saw earlier. It was the only way to pass that information to the instruction.

Decoding the code array, we see:

<table cellspacing="0" cellpadding="2" border="1"><tbody><tr><td valign="top" width="92">Index</td><td valign="top" width="138">Instruction</td><td valign="top" width="148">Op Code/Argument</td><td valign="top" width="158">String Table Reference</td><td valign="top" width="174">Description</td></tr><tr><td valign="top" width="93">0</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L73">Lazybranch</a></td><td valign="top" width="148">23</td><td valign="top" width="158">&#160;</td><td valign="top" width="174" rowspan="2">Lazily branch to the <a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L91">Stop</a> instruction at offset 21.</td></tr><tr><td valign="top" width="93">1</td><td valign="top" width="138">&#160;</td><td valign="top" width="148">21</td><td valign="top" width="157">&#160;</td></tr><tr><td valign="top" width="93">2</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L81">Setmark</a></td><td valign="top" width="149">31</td><td valign="top" width="156">&#160;</td><td valign="top" width="174">Push our current state onto a stack in case we need to backtrack later.</td></tr><tr><td valign="top" width="93">3</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L57">Multi</a></td><td valign="top" width="149">12</td><td valign="top" width="156">&#160;</td><td valign="top" width="174" rowspan="2">Perform a multi-character match of string table item 0 which is 'http://'.</td></tr><tr><td valign="top" width="93">4</td><td valign="top" width="139">&#160;</td><td valign="top" width="149">0</td><td valign="top" width="156">"http://"</td></tr><tr><td valign="top" width="93">5</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L81">Setmark</a></td><td valign="top" width="149">31</td><td valign="top" width="156">&#160;</td><td valign="top" width="174">Push our current state onto a stack in case we need to backtrack later.</td></tr><tr><td valign="top" width="94">6</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L43">Setrep</a></td><td valign="top" width="149">2</td><td valign="top" width="155">&#160;</td><td valign="top" width="174" rowspan="3">Perform a set repetition match of length 1 on the set stored at string table position 1, which represents [^\s/].</td></tr><tr><td valign="top" width="94">7</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">1</td><td valign="top" width="155">&quot;\x1\x2\x1\x2F\x30\x64&quot;</td></tr><tr><td valign="top" width="94">8</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">1</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">9</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L47">Setloop</a></td><td valign="top" width="149">5</td><td valign="top" width="155">&#160;</td><td valign="top" width="174" rowspan="3">Match the set [^\s/] in a loop at most Int32.MaxValue times.</td></tr><tr><td valign="top" width="94">10</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">1</td><td valign="top" width="155">&quot;\x1\x2\x1\x2F\x30\x64&quot;</td></tr><tr><td valign="top" width="94">11</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">2147483647</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">12</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L82">Capturemark</a></td><td valign="top" width="149">32</td><td valign="top" width="155">&#160;</td><td valign="top" width="174" rowspan="3">Capture into group #1, the string between the mark set by the last Setmark and the current position.</td></tr><tr><td valign="top" width="94">13</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">1</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">14</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">-1</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">15</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L45">Oneloop</a></td><td valign="top" width="149">3</td><td valign="top" width="155">&#160;</td><td valign="top" width="174" rowspan="3">Match Unicode character 47 (a '/') in a loop for a maximum of 1 time.</td></tr><tr><td valign="top" width="94">16</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">47</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">17</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">1</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">18</td><td valign="top" width="138"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L82">Capturemark</a></td><td valign="top" width="149">32</td><td valign="top" width="155">&#160;</td><td valign="top" width="174" rowspan="3">Capture into group #0, the contents between the first Setmark instruction and the current position.</td></tr><tr><td valign="top" width="94">19</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">0</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">20</td><td valign="top" width="138">&#160;</td><td valign="top" width="149">-1</td><td valign="top" width="155">&#160;</td></tr><tr><td valign="top" width="94">21</td><td valign="top" width="139"><a href="https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx#L91">Stop</a></td><td valign="top" width="151">40</td><td valign="top" width="160">&#160;</td><td valign="top" width="174">Stop the regex.</td></tr></tbody></table>

We can now see that our regex has turned into a simple "program" that will be executed later.

## Prefix Optimizations

We could stop here, but we'd miss the fun "optimizations." With our pattern and search string, the optimizations will actually slow things down, but the code generator is oblivious to that. The basic idea behind prefix optimizations is to quickly jump to where the match *might* start. It does this by [using](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L289) a [RegexFCD](https://web.archive.org/web/20090402044607id_/http://www.koders.com/csharp/fid4F4894401F2873F7C00CC3CF96F851ED3ED10D69.aspx) class that I'm guessing stands for "Regex First Character Descriptor."

With our regex, the [FirstChars](https://web.archive.org/web/20090402044607id_/http://www.koders.com/csharp/fid4F4894401F2873F7C00CC3CF96F851ED3ED10D69.aspx#L53) functions [notices our "http://" 'Multi' node](https://web.archive.org/web/20090402044607id_/http://www.koders.com/csharp/fid4F4894401F2873F7C00CC3CF96F851ED3ED10D69.aspx#L462) and [determines](https://web.archive.org/web/20090402044607id_/http://www.koders.com/csharp/fid4F4894401F2873F7C00CC3CF96F851ED3ED10D69.aspx#L524) that any match must start with an 'h'. If we had alternations, the first character of each alternation would be added to make a limited set of potential first characters. With this optimization alone, we can skip all characters in the text that aren't in this approved "white list" of first characters without having to execute any of the above RegexCode.

But wait... there's an even trickier optimization! The optimizer [discovers](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L295) that the first thing the regex must match is a simple string literal: [a 'Multi' node](https://web.archive.org/web/20090402044607id_/http://www.koders.com/csharp/fid4F4894401F2873F7C00CC3CF96F851ED3ED10D69.aspx#L106). This means that we can use the [RegexBoyerMoore](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx) class which applies the [Boyer-Moore](http://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string_search_algorithm) search algorithm.

The key insight is that we don't have to check each character of the text. We only need to look at last character to see if it's even worth checking the rest.

For example, if our sample text is "Welcome to http://www.moserware.com/!" and we're searching for "http://" which is 7 characters, we first look at the 7th character of the text which is 'e'. Since 'e' is not the 7th character of what we're looking for (which is a '/'), we know that there couldn't possibly be a match and so we don't need to bother checking all previous 6 characters because there isn't even an 'e' in what we're looking for. The tricky part is what to do if the what we find *is* in the string that we're trying to match, but it isn't the last '/' character.

The specifics are handled in [straightforward](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx#L91) [way](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx#L166) with some minor optimizations to reduce memory needs given 65,000+ possible Unicode characters. For each character, the maximum possible skip is calculated.

For "http://", we come up with this skip table:

| Character | Characters to skip ahead |
|-----------|--------------------------|
| /         | 0 |
| :         | 2 | 
| h         | 6 | 
| p         | 3 | 
| t         | 4 |
| all others| 7 |

This table tells us that if we find an 'e' then we can skip ahead 7 characters without even checking the previous 6 characters. If we find a 'p', then we can skip ahead at least 3 characters before performing a full check, and if we find a '/' then we could be on the last character and need to check other characters (e.g. skip ahead 0).

There is one more optimization that [looks for anchors](https://web.archive.org/web/20090402044607id_/http://www.koders.com/csharp/fid4F4894401F2873F7C00CC3CF96F851ED3ED10D69.aspx#L133), but none apply to our regex, so it's ignored.

We're done! We made it to the end of the [RegexWriter phase](https://web.archive.org/web/20090401224618id_/http://www.koders.com/csharp/fidC6F7EB8E11A6BF080CFA281BEEE003B5FAAB4AD9.aspx#L302). The "[RegexCode](https://web.archive.org/web/20090401224645id_/http://www.koders.com/csharp/fidF4B2B64D471D5B7401063DE2054CB33F28BDA026.aspx)" internal representation consists of these critical parts:

1.  The regex code we created.
2.  The string table derived from the regex that the code uses (e.g. our "Multi" and "Setrep" instructions have string table references).
3.  The maximum size of our backtracking stack. (Ours is 7, this will make more sense later.)
4.  A mapping of named captures to their group numbers. (We don't have any in our regex, so this is empty.)
5.  The total number of captures. (We have 2.)
6.  The RegexBoyerMoore prefix that we calculated. (This applies to us since we have a string literal at the start.)
7.  The possible first characters in our prefix. (In our case, we calculated this to be an 'h'.)
8.  Our anchors. (We don't have any.)
9.  An indicator whether this should be a RightToLeft match. (In our case, we use the default which is false.)

Every regex passes through this step. It applies to our measly regex with a code size of 21 as much as it does to a gnarly [RFC2822](http://tools.ietf.org/html/rfc2822#section-3.4.1) [compliant regex](http://www.regular-expressions.info/email.html) that has 175. These nine items completely describe *everything* that we'll do with our regex and they never change.

## In need of an interpreter

Now that we have the RegexCode, the [match](http://msdn.microsoft.com/en-us/library/twcw2f1c.aspx) method will [run](https://web.archive.org/web/20090402061020id_/http://www.koders.com/csharp/fid7F5AE3CBB76E9E51E24DEA0DB54B86C173369E88.aspx#L919) and create a [RegexRunner](http://www.koders.com/csharp/fidABFA3D15F7A596443DCE29D6AE984F1192048031.aspx) which is the "driver" for the regex matching process. Since we didn't specify the "Compiled" flag, we'll use the [RegexInterpreter](http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx) runner.

Before the interpreter starts [scanning](http://www.koders.com/csharp/fidABFA3D15F7A596443DCE29D6AE984F1192048031.aspx#L81), it [notices](http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L364) that we have a valid Boyer-Moore prefix optimization and it [uses it](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx#L269) to quickly locate the start of the regex:

<table cellspacing="0" cellpadding="2" border="1"><tbody><tr><td valign="top">Index</td><td valign="top">0</td><td valign="top">1</td><td valign="top">2</td><td valign="top">3</td><td valign="top">4</td><td valign="top">5</td><td valign="top">6</td><td valign="top">7</td><td valign="top">8</td><td valign="top">9</td><td valign="top">10</td><td valign="top">11</td><td valign="top">12</td><td valign="top">13</td><td valign="top">14</td><td valign="top">15</td><td valign="top">16</td><td valign="top">17</td><td valign="top">18</td><td valign="top">19</td><td valign="top">20</td><td valign="top">21</td><td valign="top">22</td><td valign="top">23</td><td valign="top">24</td><td valign="top">25</td><td valign="top">26</td><td valign="top">27</td><td valign="top">28</td><td valign="top">29</td><td valign="top">30</td><td valign="top">31</td><td valign="top">32</td><td valign="top">33</td><td valign="top">34</td><td valign="top">35</td><td valign="top">36</td></tr><tr><td valign="top">Character</td><td valign="top">W</td><td valign="top">e</td><td valign="top">l</td><td valign="top">c</td><td valign="top">o</td><td valign="top">m</td><td valign="top">e</td><td valign="top">&#160;</td><td valign="top">t</td><td valign="top">o</td><td valign="top">&#160;</td><td valign="top">h</td><td valign="top">t</td><td valign="top">t</td><td valign="top">p</td><td valign="top">:</td><td valign="top">/</td><td valign="top">/</td><td valign="top">w</td><td valign="top">w</td><td valign="top">w</td><td valign="top">.</td><td valign="top">m</td><td valign="top">o</td><td valign="top">s</td><td valign="top">e</td><td valign="top">r</td><td valign="top">w</td><td valign="top">a</td><td valign="top">r</td><td valign="top">e</td><td valign="top">.</td><td valign="top">c</td><td valign="top">o</td><td valign="top">m</td><td valign="top">/</td><td valign="top">!</td></tr><tr><td valign="top">Scan Order</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">1</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">9</td><td valign="top">8</td><td valign="top">2 & 7</td><td valign="top">6</td><td valign="top">5</td><td valign="top">4</td><td valign="top">3</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td><td valign="top">&#160;</td></tr></tbody></table>

It first looks at the 7th character and finds an 'e' instead of the '/' that it wanted. The skip table tells it that 'e' isn't in any possible match, so it jumps ahead 7 more characters where it finds a 't'. The skip table [tells it](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx#L318) to jump ahead 4 more characters where it *finally* finds the '/' it wanted. It then [verifies](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx#L326) that this is the last character of our "http://" prefix. With a valid prefix found, we [prepare for a match](https://web.archive.org/web/20090402044622id_/http://www.koders.com/csharp/fidABFA3D15F7A596443DCE29D6AE984F1192048031.aspx#L187) in case we're lucky and the rest of the regex matches.

The bulk of the interpreter is in its "[Go](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L403)" method which is a 700 line switch statement that interprets the RegexCode we created earlier. The only interesting part is that the interpreter keeps two stacks to keep its state in case it needs to backtrack and abandon a path it took. The "run **s**tack" records where in the search string an operation begins while the "run **t**rack" records the RegexCode instruction that could potentially backtrack. Any time there is a chance that the interpreter could go down a wrong path, it pushes its state onto these stacks so that it can potentially try something else later.

On our string, the following instructions execute:

1.  [Lazybranch](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L430) - This is a branch that is "lazy." It will only occur if we fail and have to backtrack to this instruction. In case there are problems, we push 11 (the string offset to the start of "http://") onto the "run **s**tack" and 0 (the RegexCode offset for this instruction) onto the "run **t**rack." The branch is to code offset 21 which is the "Stop" instruction.
2.  [Setmark](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L441) - We save our position in case we have to backtrack.
3.  [Multi](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L824) - A multi-character match. The string to match is at offset 0 in the string table (which is "http://").
4.  [Setmark](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L441) - Another position save in case of a backtrack. Since the Multi code succeeded, we push our "run **s**tack" offset of 18 (the start of "www.") and our "run **t**rack" code position of 5
5.  [Setrep](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L883) - Loads the "\x1\x2\x1\x2F\x30\x64" set representation at offset 1 in the string table that we calculated earlier. It reads an operand from the execution stack that we should verify that the set **rep**eats exactly once. It calls [CharInClassRecursive](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L815) that does the following:
1.  It sees that the first character, 'w', is not in the character range ['/', '0'). This check corresponds to the '/' in the "[^\s/]" part of the regex.
2.  It next tries [CharInCategory](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L874) which notes that 'w' is part of the "LowercaseLetter" [UnicodeCategory](http://msdn.microsoft.com/en-us/library/system.globalization.unicodecategory.aspx). The magic number 0x64 in our set tells us to [do](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L890) a [Char.IsWhiteSpace](http://msdn.microsoft.com/en-us/library/t809ektx.aspx) check on it. This too fails.
3.  Although both checks fail, the interpreter sees that it needs to [flip the result](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L828) since it is a negated (^) set. This makes the character class match succeed.

6.  [Setloop](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L948) - A "loop" instruction is like a "rep" one except that it isn't forced to match anything. In our case, we see that we loop for a maximum of Int32.MaxValue times on the same set we saw in "Setrep." Here you can see that the code generation phase turned the "+" in "[^\s/]+" of the regex into a Setrep of 1 followed by a Setloop. This is equivalent to "[^\s/][^\s/]\*". The loop keeps chomping characters until it finds the '/' which causes it to call [BackwardNext()](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L321) which sets the current position to just before the final '/'.
7.  [CaptureMark](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L470) - Here we start capturing group 1 by popping the "run **s**tack" which gives us 18. Our current offset is 35. We [capture](https://web.archive.org/web/20090402044622id_/http://www.koders.com/csharp/fidABFA3D15F7A596443DCE29D6AE984F1192048031.aspx#L354) the string between these two positions, "www.moserware.com", and [keep it](https://web.archive.org/web/20090402044622id_/http://www.koders.com/csharp/fidABFA3D15F7A596443DCE29D6AE984F1192048031.aspx#L330) for later use in case the entire regex succeeds.
8.  [Oneloop](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L900) - Here we do a loop at most one time that will check for the '/' character. It succeeds.
9.  [CaptureMark](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L470) - We capture into group 0 the value between the offset on the "run **s**tack", which is 11 (the start of "http://"), and the last character of the string at offset 36. The string between these offsets is "http://www.moserware.com/".
10. [Stop](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L414) - We're done executing RegexCode and can stop the interpreter.

Since we stopped with successful captures, the Match is declared [a success](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.group.success.aspx). Sure enough, if we look at our console window, we see:

    Full uri = 'http://www.moserware.com/' 
    Host ='www.moserware.com'

## Backtracking Down Unhappy Paths

I can hear the cursing shouts of ^#!@.*#!$ from the regex mob coming towards me. They're miffed that I used a toy regular expression with a pathetically easy search text that didn't do anything "interesting."

The mob really shouldn't be that worried. We already have all the essential tools we need to understand how things work.

One common issue that you have to deal with in a "real" regular expression is backtracking.

Let's say you have a search text and pattern like this:

{% highlight c# %}
string text = "This text has 1 digit in it"; 
string pattern = @".*\d"; Regex.Match(text, pattern);
{% endhighlight %}

You'd recognize the parse tree:

![](/assets/how-net-regular-expressions-really-work/RegexParseTreeDotStarDigit.png)

The only thing new about it is that the '.' pattern was translated into a "Notone" node that matches anything except one particular character (in our case, a line feed). We see that the set follows the obscure, but compact representation. The only thing new to report is that '\\x09' is the magic number to represent all Unicode digits (which the [Turkey Test](http://www.moserware.com/2008/02/does-your-code-pass-turkey-test.html) showed is more than just [0-9]).

It's painful to watch the regex interpreter work so hard for this match. The ".\*" puts it [in a Notoneloop](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L924) that goes right to the end of the string since it doesn't find a line feed ('\\n'). It then looks for [the Set](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L817) that represents "\\d" and it fails. It has no choice but to backtrack by executing the "[RegexCode.Notoneloop \| RegexCode.Back](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L973)" composite instruction which backtracks one character by resetting the "run **t**rack" to be the Set instruction again, but this time it will start one character earlier.

Even in our insanely simple search string, the interpreter has to backtrack by executing "[RegexCode.Notoneloop \| RegexCode.Back](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L973)" and retesting [the Set](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L817) a total of *thirteen times*.

An almost identical process occurs if we had used a lazy match regular expression like ".\*?\\d". The difference is that it does a "[Notonelazy](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L1004)" instruction and then gets caught up in a "[RegexCode.Notonelazy \| RegexCode.Back](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L1050)" backtrack and [Set match](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L817) attempt that happens *fourteen times*. Each iteration of the loop causes the "[Notonelazy](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L1004)" instruction to add one more character instead of removing one like the "[Notoneloop](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L924)" instruction had to. This is typical:

> In situations where the decision is between "make an attempt" and "skip an attempt," as with items governed by quantifiers, the engine always chooses to first *make* the attempt for *greedy* quantifiers, and to first *skip* the attempt for *lazy* (non-greedy) ones. *[Mastering Regular Expressions](http://www.amazon.com/gp/product/0596528124?ie=UTF8&tag=moserware-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596528124)*, p.159

If we had a little more empathy for the regex interpreter, we would have written "[^\d]*\d" and avoided all the backtracking, but it wouldn't have shown this common error.

Alternations such as "hello\|world" are handled with backtracking. Before each alternative is attempted, the current position is saved on the "run **t**rack" and "run **s**tack." If the alternate fails, the regex engine resets the position to what it was before the alternate was tried and the next alternate is attempted.

Now, we can even understand how more advanced concepts like [atomic grouping](http://www.regular-expressions.info/atomic.html) work. If we use a regex like:

    \w+:

to match the names of email headers as in:

    Subject: Hello World!

Things will work well. The problem will come when we try to match against

    Subject

We already know that there is going to be a backtracking since "\\w+" will match the whole string and then backtracking will occur as the interpreter desperately tries to match a ':'. If we used atomic grouping, as in:

    (?>\w+):

We would see that the generated RegexCode has two extra instructions of [Setjump](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L701) and [Forejump](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L723) in it. These instructions tell the interpreter to do unconditional jumps after matching the "\\w+". As [the comment](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L723) for "Forejump" indicates, these unconditional jumps will "zap backtracking state" and be much more efficient for a failed match since backtracking won't occur.

## Loose Ends

There are some minor details left. The first time you use any regex, a [lot](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L102) [of](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L260) [work](https://web.archive.org/web/20090402012958id_/http://www.koders.com/csharp/fid14AB8BA02EE8A6DBA830F1DCC147C2B17F0B3DE0.aspx#L358) goes on initializing all the [character classes](http://msdn.microsoft.com/en-us/library/20bw873z.aspx) that are stored as static variables. If you just timed a single Regex, your numbers would be highly skewed by this process.

Another common issue is whether you should use the RegexOptions.Compiled flag. Compiling is handled by the [RegexCompiler](https://web.archive.org/web/20090429030946id_/http://www.koders.com/csharp/fid7CC2751EC539A3CCF3A96A3D82E38D6E6D7B79F3.aspx#L44) class. The interesting aspects of the IL code generation is handled exactly like the interpreter, as indicated by [this comment](https://web.archive.org/web/20090429030946id_/http://www.koders.com/csharp/fid7CC2751EC539A3CCF3A96A3D82E38D6E6D7B79F3.aspx#L1554):

{% highlight c# %}
/* 
 * The main translation function. It translates the logic for a single opcode at 
 * the current position. The structure of this function exactly mirrors 
 * the structure of the inner loop of RegexInterpreter.Go(). 
 * 
 * The C# code from RegexInterpreter.Go() that corresponds to each case is 
 * included as a comment. 
 * 
 * Note that since we're generating code, we can collapse many cases that are 
 * dealt with one-at-a-time in RegexIntepreter. We can also unroll loops that 
 * iterate over constant strings or sets. 
 */
{% endhighlight %}

We can see that there *is* some optimization in the generated code. The down side is that we have to generate all the code regardless of if we use all of it or not. The interpreter only uses what it needs. Additionally, unless we use [Regex.CompileToAssembly](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regex.compiletoassembly.aspx) to save the compiled code to a DLL, we'll end up doing the entire process of creating the parse tree, RegexCode, and code generation at runtime.

Thus, for most cases, it seems that RegexOptions.Compiled isn't worth the effort. But it's good to keep in mind that there are exceptions when performance is critical and your regex can benefit from it (otherwise, why have the option at all?).

Another option is [RegexOptions](http://msdn.microsoft.com/en-us/library/system.text.regularexpressions.regexoptions.aspx).IgnoreCase that makes everything case insensitive. The vast majority of the process stays the same. The only difference is that all instructions that compare characters will convert each [System.Char](http://msdn.microsoft.com/en-us/library/system.char.aspx) to lower case, mostly using the [Char.ToLower](http://msdn.microsoft.com/en-us/library/xt041c19.aspx) method. This sounds reasonable, but it's not quite perfect. For example, in Koine Greek, the word for "[moth](http://www.blueletterbible.org/lang/lexicon/lexicon.cfm?Strongs=G4597&t=NKJV)" goes from uppercase to lowercase like this:

![](/assets/how-net-regular-expressions-really-work/mothUpperAndLower.png)

That is, in Greek, when a "sigma" (Σ) appears in lowercase at the end of a word, it uses a [different letter](http://blogs.msdn.com/michkap/archive/2005/05/26/421987.aspx) (ς) than if it appeared anywhere else (σ). RegexOptions.IgnoreCase can't handle cases that need more context than a single [System.Char](http://msdn.microsoft.com/en-us/library/system.char.aspx) even though the string comparison functions can handle this. Consider this example:

{% highlight c# %}
string mothLower = "σής";
string mothUpper = mothLower.ToUpper(); // "ΣΉΣ"
bool stringsAreEqualIgnoreCase = mothUpper.Equals(mothLower, StringComparison.CurrentCultureIgnoreCase);  // true 
bool stringsAreEqualRegex = Regex.IsMatch(mothLower, mothUpper, RegexOptions.IgnoreCase); // false
{% endhighlight %}

This also means that .NET's Regex won't do well with characters outside the [Basic Multilingual Plane](http://en.wikipedia.org/wiki/Basic_Multilingual_Plane) that need to be represented by more than one [System.Char](http://msdn.microsoft.com/en-us/library/system.char.aspx) as a "[surrogate pair](http://msdn.microsoft.com/en-us/library/8k5611at.aspx)."

I bring all of these "cases" up because it obviously troubled one of the Regex programmers who wrote this [comment](https://web.archive.org/web/20090402013015id_/http://www.koders.com/csharp/fidC88A6970F260F6826C679E703634322F3C553827.aspx#L1859) *[twice](https://web.archive.org/web/20090402044617id_/http://www.koders.com/csharp/fidA16EF1E737BCF735FD1DE4D39E0E1AD9851FC2A7.aspx#L64)*:

{% highlight c# %}
// We do the ToLower character by character for consistency.  With surrogate chars, doing 
// a ToLower on the entire string could actually change the surrogate pair.  This is more correct 
// linguistically, but since Regex doesn't support surrogates, it's more important to be 
// consistent.
{% endhighlight %}

You can tell the author was fully anticipating the [bug reports](http://code.logos.com/blog/2008/07/net_regular_expressions_and_unicode.html) that eventually came as a result of this decision. Unfortunately, due to the way the code is structured, changing this behavior would take a hefty overhaul of the engine and would require a massive amount of regression testing. I'm guessing this is the reason why it won't be coming in a service pack anytime soon.

The last interesting option that affects most of the code is RegexOptions.RightToLeft. For the most part, this affects where the searching starts and how a "[bump](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L229)" is applied. When the engine wants to move forward or get the characters to the "right", it checks this option to see if it should move +1 or -1 character from the current position. It's a simple idea, but its implementation is with many "[if(!runrtl)](https://web.archive.org/web/20090401214129id_/http://www.koders.com/csharp/fidE76CE858561A50AF7A1D9030DC8F2F4D6DEF839D.aspx#L247)" statements spread throughout the code.

Finally, you might be interested in how [Mono](http://www.mono-project.com/Main_Page)'s regular expression compares with Microsoft's. The good news is that the code [is also available](http://anonsvn.mono-project.com/viewvc/trunk/mcs/class/System/System.Text.RegularExpressions/) online as well. In general, Mono's implementation is very similar. Here are some of the (minor) differences:

-   Mono's parse tree has a similar shape, but it uses more strongly typed classes. For example, sets such as [^\s/] are given their own class rather than encoded as a single string. 
-   The Boyer-Moore prefix optimization is done in the [QuickSearch](http://anonsvn.mono-project.com/viewvc/trunk/mcs/class/System/System.Text.RegularExpressions/quicksearch.cs?view=log) class. It is calculated at run-time and is only used if the search string is longer than 5 characters. 
-   The regex machine doesn't have a separate string table for referencing strings like "http://". Each character is passed in as an argument to the instruction.

## Conclusion

Weighing in around 14,000 lines of code, .NET's regular expression engine takes awhile to digest. After getting over the shock of its size, it was relatively straightforward to understand. Seeing the real source code, with its occasional funny comments, provided insight that Reflector simply couldn't offer. In the end, we see that a .NET regular expression pattern is simply a compact representation for its internal RegexCode machine language.

This whole process has allowed me to finally connect with regular expressions and give them a splash of empathy. Seeing the horror of backtracking first hand in the debugger was enough for me to want to do everything in my power to get rid of it. Following the translation process down to the RegexCode level clued me into how my regex pattern will actually execute. Feeling the wind fly by a regex using the Boyer-Moore prefix optimization has encouraged me to do whatever I can to put string literals at the front of a pattern.

It's all these little things that add up to a blazingly fast regular expression.