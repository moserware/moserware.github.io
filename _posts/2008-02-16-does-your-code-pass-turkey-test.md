---
layout: post
title: "Does Your Code Pass The Turkey Test?"
date: 2008-02-16 07:47:00
updated: 2014-02-07 16:20:31
permalink: /2008/02/does-your-code-pass-turkey-test.html
---
Over the past 6 years or so, I've failed each item on "The Turkey Test." It's very simple: will your code work properly on a person's machine in or around the country of Turkey? Take this simple test.

1. Parsing dates from a configuration file using [DateTime.Parse(string)](http://msdn2.microsoft.com/en-us/library/1k1skd40.aspx): 

    ![](/assets/does-your-code-pass-turkey-test/turkeyDateTime.png)

    Does it pass "The Turkey Test?"

    Nope:

    ![](/assets/does-your-code-pass-turkey-test/turkeyDateTimeResult.png)

    **Reason:** Turkish people write July 4th, 2008 as "04.07.2008"

    **Fix:** Always specify what format your date is in. In this case, we use a [DateTimeFormat.InvariantInfo](http://msdn2.microsoft.com/en-us/library/system.globalization.datetimeformatinfo.invariantinfo.aspx) which just *happens* to be USA English's format (more or less):

    ![](/assets/does-your-code-pass-turkey-test/turkeyDateTimeFix.png)

    Which gives us what we were expecting:

    ![](/assets/does-your-code-pass-turkey-test/turkeyDateTimeResultFixed.png)
    
    [Scott Hanselman](http://www.hanselman.com/blog/) likes [to talk](http://www.hanselman.com/blog/ParsingACultureawareDateTimeOrAvoidingInStr.aspx) [about DateTime](http://www.hanselman.com/blog/DateParseExactAndTheSubtleGooThatIsDateTimeFormatStrings.aspx)s. (Be sure to see his DateTime [interview question](http://www.hanselman.com/blog/WhatGreatNETDevelopersOughtToKnowMoreNETInterviewQuestions.aspx)).

2. Ok, ok. You knew about dates. I sort of did, but I still got it wrong the first few times. What about this seemingly simple piece of code:

    ![](/assets/does-your-code-pass-turkey-test/turkeyDouble.png)

    Does it pass "The Turkey Test?"

    Nope:

    ![](/assets/does-your-code-pass-turkey-test/turkeyDoubleResult.png)

    **Reason:** Turkish people use a period to group digits (like people in the USA use a comma). Instead of getting a 4.5% discount like you intended, Turkish people will be getting at 45% discount.

    **Fix:** Again, always specify your format explicitly:

    ![](/assets/does-your-code-pass-turkey-test/turkeyDoubleFix.png)

    Which saves your company from having to go out of business from having too high of discounts:

    ![](/assets/does-your-code-pass-turkey-test/turkeyDoubleResultFixed.png)

3.  Say your application reads in some command line parameter:

    ![](/assets/does-your-code-pass-turkey-test/turkeyStringUSFail.png)

    Forget about Turkey, this won't even pass in the USA. You need a case insensitive compare. So you try:

    [String.Compare(string,string,bool ignoreCase)](http://msdn2.microsoft.com/en-us/library/zkcaxw5y.aspx):

    ![](/assets/does-your-code-pass-turkey-test/turkeyStringCompareBad.png)

    Or using [String.ToLower()](http://msdn2.microsoft.com/en-us/library/e78f86at.aspx):

    ![](/assets/does-your-code-pass-turkey-test/turkeyStringToLowerBad.png)

    Or [String.Equals](http://msdn2.microsoft.com/en-us/library/c64xh8f9(VS.80).aspx) with [CurrentCultureIgnoreCase](http://msdn2.microsoft.com/en-us/library/system.stringcomparer.currentcultureignorecase.aspx):

    ![](/assets/does-your-code-pass-turkey-test/turkeyStringCCIC.png)
    
    Or even a trusty [Regular Expression](http://msdn2.microsoft.com/en-us/library/system.text.regularexpressions.regex.aspx):

    ![](/assets/does-your-code-pass-turkey-test/turkeyStringRegexBad.png)

    Do *any* of these pass "The Turkey Test?"

    Not a chance!

    **Reason:** You've been hit with the "Turkish I" problem.

    ![](/assets/does-your-code-pass-turkey-test/TurkishIToUpper.png)

    ![](/assets/does-your-code-pass-turkey-test/TurkishIToLower.png)

    [As](http://blogs.msdn.com/deeptanshuv/archive/2004/09/04/225720.aspx) [discussed](http://www.hanselman.com/blog/UpdateOnTheDasBlogTurkishIBugAndAReminderToMeOnGlobalization.aspx) [by](http://blogs.msdn.com/michkap/archive/2004/12/03/274288.aspx) [lots](http://msdn2.microsoft.com/en-us/library/ms973919.aspx) [and](http://msdn2.microsoft.com/en-us/library/ms994325.aspx#cltsafcode_topic4) [lots](http://www.mail-archive.com/users@lists.ironpython.com/msg04721.html) [of](http://msdn2.microsoft.com/en-us/library/xk2wykcz(VS.71).aspx) [people](http://cafe.elharo.com/blogroll/turkish/), the "I" in Turkish behaves differently than in most languages. [Per the Unicode standard](http://www.unicode.org/charts/PDF/U0100.pdf), our lowercase "i" becomes "İ" (U+0130 "Latin Capital Letter I With Dot Above") when it moves to uppercase. Similarly, our uppercase "I" becomes "ı" (U+0131 "Latin Small Letter Dotless I") when it moves to lowercase.

    **Fix:** Again, use an [ordinal (raw byte) comparer](http://msdn2.microsoft.com/en-us/library/system.stringcomparer.ordinalignorecase.aspx), or [invariant culture](http://msdn2.microsoft.com/en-us/library/system.stringcomparer.invariantcultureignorecase.aspx) for comparisons unless you absolutely need culturally based linguistic comparisons (which give you uppercase I's with dots in Turkey)

    ![](/assets/does-your-code-pass-turkey-test/turkeyStringCompareGood.png)
    
    Or 
    
    ![](/assets/does-your-code-pass-turkey-test/turkeyStringToLowerGood.png)
    
    Or 
    
    ![](/assets/does-your-code-pass-turkey-test/turkeyStringOIC.png)
    
    And finally, a fix to our Regex friend: 
    
    ![](/assets/does-your-code-pass-turkey-test/turkeyStringRegexGood.png)

4.  My final example is especially embarrassing. I was actually smug when I wrote something like this (note the comment):

    ![](/assets/does-your-code-pass-turkey-test/turkeyZipCodeRegexBad.png)

    Does this simple program pass "The Turkey Test?"

    You're probably hesitant to say "yes" ... and rightly so. Because this too fails the test.

    **Reason:** As [Raymond Chen points out](http://blogs.msdn.com/oldnewthing/archive/2004/03/09/86555.aspx), there are more than 10 digits out there. Here, I use real Arabic digits (see page 4 of [this code table](http://www.unicode.org/charts/PDF/U0600.pdf)):

    ![](/assets/does-your-code-pass-turkey-test/turkeyZipCodeRegexFireworks.png)

    **Fix:** A [CultureInvariant](http://msdn2.microsoft.com/en-us/library/z0sbec17.aspx) won't help you here. The only option is to explicitly specify the character range you mean:

    ![](/assets/does-your-code-pass-turkey-test/turkeyZipCodeRegexGoodExplicit.png)

    Or use the RegexOptions.ECMAScript option. In <s>Java</s>[ECMAScript](http://en.wikipedia.org/wiki/ECMAScript), "\\d" means [0-9] which gives us:

    ![](/assets/does-your-code-pass-turkey-test/turkeyZipCodeRegexGoodECMAScript.png)

"The Turkey Test" poses a very simple question, but yet is full of surprises for guys like me who didn't realize all the little details. Turkey, as we saw above, is sort of like "New York, New York" in the [classic Frank Sinatra song](http://www.youtube.com/results?search_query=frank+sinatra+%22new+york%2C+new+york%22&search_type=):

> "These little town blues, are melting away 
> I'll make a brand new start of it - in old New York 
> **If I can make it there, I'll make it anywhere**
> Its up to you - New York, New York"

If your code properly runs in Turkey, it'll probably work anywhere.

This brings us to the logo program:

![](/assets/does-your-code-pass-turkey-test/turkeyTestLogo.png)

**"Turkey Test" Logo Program Requirements**:

1.  Read Joel Spolsky's [basic introduction to Unicode](http://www.joelonsoftware.com/articles/Unicode.html) to understand the absolute minimum about it.
2.  Read Microsoft's "[New Recommendations for Using Strings in Microsoft .NET 2.0](http://msdn2.microsoft.com/en-us/library/ms973919.aspx)" article and [this post](http://blogs.msdn.com/bclteam/archive/2007/05/31/string-compare-string-equals-josh-free.aspx) by the BCL team.
3.  Always specify culture and number formatter for all string, parsing, and regular expression you use.
4.  If you read data from the user and want to process it in a language sensitive matter (e.g. sorting), use the [CurrentCulture](http://msdn2.microsoft.com/en-us/library/system.globalization.cultureinfo.currentculture.aspx). If none of that matters, really try to use use [Ordinal](http://msdn2.microsoft.com/en-us/library/system.stringcomparer.ordinal.aspx) comparisons.
5.  Run [FxCop](http://msdn2.microsoft.com/en-us/library/bb429476(VS.80).aspx) on your code and make sure you have no [CA1304](http://msdn2.microsoft.com/en-us/library/ms182189.aspx) (SpecifyCultureInfo) or [CA1305](http://msdn2.microsoft.com/en-us/library/ms182190.aspx) (SpecifyIFormatProvider) warnings.
6.  Unit test string comparing operations in the "[tr-TR](http://en.wikipedia.org/wiki/Turkey)" culture as well as your local culture (unless you actually live in Turkey, then use a culture like "en-US").

Having successfully passed the above requirements, your software will finally be able to wear "Passed 'The Turkey Test'" logo with pride.

**Note:** Special thanks to my coworker, Evan, for calling the 3rd type of error "Turkeys." Also, thanks to [Chip and Dan Heath](http://www.madetostick.com/) for the "Sinatra Test" idea.