---
layout: post
title: "Life, Death, and Splitting Secrets"
date: 2011-11-21 08:43:00
updated: 2014-02-06 14:56:02
permalink: /2011/11/life-death-and-splitting-secrets.html
---
(**Summary**: I created [a program](https://github.com/moserware/SecretSplitter) to help back up important data like your master password in case something happens to you. By splitting your secret into pieces, it provides a circuit breaker against a single point of failure. I’m giving it away as a free open source program with the hope that others might find it useful in addressing this aspect of our lives. Feel free to [use the program](https://github.com/moserware/SecretSplitter/releases/latest) and follow along with just the screenshots below or read all sections of this post if you want more context.)

## Background

I just couldn’t do it.

<img alt="Grandma and Jeff" title="Grandma and Jeff" src="/assets/life-death-and-splitting-secrets/Grandma_and_Jeff_320.jpg" align="right" style="border:0; margin: 0px 0px 15px 15px; display: inline">My grandma died at this time last year from a stroke. She was a great woman. I still miss her. In that emotional last week, I was reminded of great memories with her and the fragility of life. I was also reminded about important documents that I still didn’t have.

When something happens to you, be it death or incapacitation, there are some important steps that need to occur that can be greatly assisted by legal documents. For example:

1.  An [advance health care directive](http://en.wikipedia.org/wiki/Advance_health_care_directive) (aka “Living Will”) specifies what actions should (or shouldn’t) be taken with regards to your healthcare if you’re no longer able to make decisions for yourself.
2.  A [durable power of attorney](http://en.wikipedia.org/wiki/Power_of_attorney#Durable_power_of_attorney) allows you to designate someone to legally act as you if you become incapacitated.
3.  A <a href="http://en.wikipedia.org/wiki/Will_(law)">last will and testament</a> allows you to legally assign caregivers for [minor children](http://en.wikipedia.org/wiki/Minor_(law) "Typically 18 and younger.") as well as designate where you'd like your possessions to go.

My grandma had these and it helped reduce stress and anxiety in this difficult time. We knew what she would have wanted and these documents helped legally enforce that.

I had assumed that these documents were expensive and time-consuming to create. Furthermore, as a guy in my 20’s, death still seems like [a distant rumor](http://quotationsbook.com/quote/10024/ "“Death is a distant rumor to the young.” - Andy Rooney (1919 - 2011)"). As a Christian, I’m [not overly concerned](http://www.biblegateway.com/passage/?search=Philippians%201:21&version=ESV) [about death itself](http://www.biblegateway.com/passage/?search=1%20Corinthians%2015:54-57&version=ESV), but my grandma’s death reminded me that these documents are not really for me, but rather the people I’d leave behind. I knew that if something happened to me, I’d potentially be leaving behind a mess, and that concern of irresponsibility compelled me to investigate what I could do.

It turns out that creating these documents is essentially a matter of filling out a form template. I [bought a program](http://www.amazon.com/gp/product/B004DLCQZ4/ref=as_li_ss_tl?ie=UTF8&tag=moserware-20&linkCode=as2&camp=217145&creative=399369&creativeASIN=B004DLCQZ4 "I used Quicken Willmaker 2011 Premium edition. I liked the premium edition because it came with a lot of extra books that made for fun reading. The 2012 version will probably be available soon.") that made it about as easy as preparing taxes online. In most cases, you just need disinterested third parties, such as friends or coworkers, to witness you signing them to make them fully legal. At most, you might have to get them notarized or filed in your county for a small fee.

One of the steps involved in filling out the “Information for Caregivers and Survivors” document is to list “[Secured Places and Passwords](http://www.nolo.com/legal-encyclopedia/help-executor-secured-places-passwords-29669.html).” It’s a helpful section that your [executor](http://en.wikipedia.org/wiki/Executor) can turn to if something happened to you in order to do things like unlock your cell phone or access your online accounts. Sure, your survivors might be able use legal force to get access without it, but only after months of [sending official documentation](https://mail.google.com/support/bin/answer.py?answer=14300). That’s a lot of hassle to put someone through. Also, it’s very likely that a lot of important things will be missed and no one would ever know they existed.

It’s [probably rational](http://research.microsoft.com/apps/pubs/?id=80436 "“The Rational Rejection of Security Advice by Users” provides some interesting counterpoints to security advice out there.") to just write your passwords down and put them in a safe which your executor knows the location of and can access in a timely matter. Alternatively, you could pay for an attorney or a [third-party service](http://mashable.com/2010/10/11/social-media-after-death/) and leave your password list with them. However, this seemed like it would cause a maintenance problem, especially as I might add or update my passwords frequently. These options would also force me to trust someone I haven’t known for a long time. Most importantly, the thought of writing down my passwords on a piece of paper, even if it was in a relatively safe place, went against every fiber of my security being.

I just couldn’t do it.

**DISCLAIMER**: The above simple approaches are probably fine and have worked for a lot of people over the years. **If you’re comfortable with these basic approaches, by all means use them and ignore this post**. These simpler approaches have less moving parts and are easy to understand. However, if you want a little more security, or need to liven up this process with a little spy novel-esque fun, read on.

## The Modern Password & Encryption Problem

As an online citizen, you don’t want to be that person. You know, the one whose password was so [easy to guess](http://blogs.wsj.com/digits/2010/12/13/the-top-50-gawker-media-passwords/ "If nothing else, promise me that none of your passwords are on this list!") that his email account was broken into and who “[wrote](http://www.nbclosangeles.com/news/tech/Email-Scams-83600577.html)” to you saying that he decided to go to Europe on a whim this past weekend but now needs you to wire him money right now and he’ll explain everything later: *that* guy.

You’ve learned that passwords like “thunder”, “thunder56”, and even “L0u&#124;>Thund3r” are terrible because they’re [easily guessed](http://www.wired.com/politics/security/commentary/securitymatters/2007/01/72458?currentPage=all "Password recovery tools are pretty good these days."). You now know that the most important aspect of a password is its [length](http://xkcd.com/936/ "“correct horse battery staple” is a start, but character variation and padding help a lot") combined with [basic padding and character variation](https://www.grc.com/haystack.htm "Steve Gibson’s Password Haystacks page is worth at least a quick glance.") such as “/* Thunder is coming! */”, “I hear <em>thunder</em>!”, or “1.big.BOOM@thunder.mil”.

In fact, you’re probably clever enough that you don’t create or remember most of your passwords anymore. You use a [password manager](http://en.wikipedia.org/wiki/Password_manager) like [LastPass](https://lastpass.com/) or [KeePass](http://keepass.info/) to automatically generate and store unique and completely random passwords for all of your accounts. This has simplified your life so that you only have to remember your “master password” that will get you into where you keep all the rest of your usernames and passwords.

<img alt="Skeleton Key" height="320" src="/assets/life-death-and-splitting-secrets/450px-Llave_bronce%5b1%5d_320.jpg" align="left" style="border:0; margin: 0px 15px 15px 0px; display: inline" width="240">

You also understand that your email account credentials are a “[skeleton key](http://www.codinghorror.com/blog/2008/06/please-give-us-your-email-password.html "It was especially sad in the Web’s early day when so many sites asked for your email login to effectively spam your contacts. It’s just inexcusable that some sites still do today.")” for almost everything else due to the widespread use of simple password reset emails. For this very reason, you probably realize that it’s critical to [protect your email login with “two-factor” authentication](http://googleblog.blogspot.com/2011/06/ensuring-your-information-is-safe.html "If you do use Gmail, really consider enabling this for your own safety and to prevent yourself from being *that* guy."). That is, your email account should at least be protected by:

1.  Something you know (your password) *and*
2.  Something you have (your cellphone), that creates or receives a one-time use code when you want to login.

On top of all of this, you try your best to follow the trusty advice that your passwords should be ones that nobody could guess and you never ever [write them](http://www.schneier.com/blog/archives/2005/06/write_down_your.html "Actually, it’s probably reasonable to write them down in keep them in your wallet") [down](http://blog.jgc.org/2010/12/write-your-passwords-down.html).

But what if something happens to you? If you’ve done everything “right,” then your master password and all your second factor details go with you.

And then there are your encrypted files. Maybe you’re keeping a [private journal](http://www.youtube.com/watch?feature=player_embedded&v=R4vkVHijdQk "You could use an encrypted journal or a separate email account. I wonder if “dear.sophie.lee@gmail.com” had two-factor authentication enabled on it. I mean, what happens if she writes back too early?") for your children to read when they grow up. Perhaps you’re living in some spy novel life where you’re worried that people will take you out to prevent something you know from being discovered. Wherever you fall on the spectrum, what do you do with such encrypted data?

Modern encryption is a bit scary because it’s so good. If you use a decent encryption program with a good password/key, then it’s very likely that no one, [not even a major government](http://www.extremetech.com/computing/105931-full-disk-encryption-is-too-good-says-us-intelligence-agency), could decrypt the file even after hundreds of years. Encryption is great for keeping prying eyes out, but it could sadden survivors that you want to have access to your data. The thought of something being lost forever might make you almost yearn for the days when you just put everything into a good safe that’s rated by how many [minutes](http://en.wikipedia.org/wiki/Safe#Class_TL-15 "For example, a TL-15 safe will resist abuse for about 15 minutes from people who know what they’re doing.") it might slow somebody down.

On a much lighter note, the “something” that happens to you doesn’t have to be so grim. Maybe you had a really relaxing three week vacation and now you can’t remember the exact keyboard combination of your password. Given that our brains have to [recreate memories each time you recall something](http://www.radiolab.org/2007/jun/07/eternal-sunshine-of-the-spotless-rat/ "Start listening at 16:45 to find out more about this interesting idea."), it’s possible that you could stress yourself out so much trying to remember your password that you effectively “forget” it. What do you do then?

When you put all your eggs into a password manager basket, you really want to [watch that basket](http://herbison.com/herbison/broken_eggs_watch.html "Whether it was Carnegie or Twain, the phrase “Put all your eggs in one basket and --- WATCH THAT BASKET!” is some good advice."). Fortunately, creating a basic plan isn’t that hard.

## A Proposed Solution

[<img alt="Example nuclear launch keys" height="320" src="/assets/life-death-and-splitting-secrets/Nuclear_missile_launch_keys%5b1%5d_320.jpg" align="right" style="border:0; margin: 0px 0px 15px 15px; display: inline" width="212">](http://en.wikipedia.org/wiki/Permissive_Action_Link)

Let’s borrow an [ancient](http://www.biblegateway.com/passage/?search=Numbers%2035:30&version=ESV "For example, the 2-3 witnesses concept appears several times in the Bible.") yet incredibly useful idea: if it’s really important to get your facts right about something, be sure to have at least two or three witnesses. This is especially true concerning matters of life and death but it also comes up when protecting really valuable things.

By the 20th century, this “[two-man rule](http://en.wikipedia.org/wiki/Two-man_rule)” was implemented in hardware to protect nuclear missiles from being launched by a lone rogue person without proper authorization. The main vault at [Fort Knox](http://en.wikipedia.org/wiki/United_States_Bullion_Depository#Construction_and_security "Also known as the “United States Buillion Depository”") is locked by multiple combinations such that no single person is entrusted with all of them. On the Internet, the master key for protecting the new secure domain name system ([DNSSEC](http://en.wikipedia.org/wiki/Domain_Name_System_Security_Extensions)) [is split between among 7 people from 6 different countries](http://www.schneier.com/blog/archives/2010/07/dnssec_root_key.html) such that at least 5 people are needed to reconstruct it in the event of an Internet catastrophe.

If this idea is good enough for protecting nuclear weapons, the Fort Knox vault, and one of the most critical security aspects on the Internet, it’s probably good enough for your password list. Besides, it can make a somewhat uncomfortable process a little more fun.

Let’s start with a simple example. Let’s say that your master password is “1.big.BOOM@thunder.mil”. You could just write it out on a piece of paper and then use scissors to cut it up. This would work if you wanted to split it among 2 people, but it has some notable downsides:

1.  It doesn’t work if you want redundancy (i.e. any 2 of 3 people being able to reconstruct it)
2.  Each piece would tell you something about the password and thus has value on its own. Ideally, we’d like the pieces to be worthless unless a threshold of people came together.
3.  It doesn’t really work for more complicated scenarios like requiring 5 of 7 people.

Fortunately, some clever math can fix these issues and give you this ability for free. I created a program called [SecretSplitter](https://github.com/moserware/SecretSplitter) to automate all of this to hopefully make the whole process painless.

Let’s say you want to require at least 2 witnesses to agree that something happened to you before your secret is available. You also want to build in redundancy such that *any* pair of people can find out your password. For this scenario, you keep the can use the default settings and press the “split” button:

[![Specifying message](/assets/life-death-and-splitting-secrets/SplitMessageSpecifyMessageThresholdAndShares_576.png)](/assets/life-death-and-splitting-secrets/SplitMessageSpecifyMessageThresholdAndShares.png "Specify the message “1.big.BOOM@thunder.mil”")

You’ll get this list of split pieces:

[![List of message shares](/assets/life-death-and-splitting-secrets/SplitMessageShares_576.png)](/assets/life-death-and-splitting-secrets/SplitMessageShares.png "List of message shares")

Notice that each piece is twice as long as your original message (about twice the size of a package tracking number). This is by design.

Now comes the hard part: you have to select three people you trust. You should have high confidence in anyone you’d entrust with a secret piece. It’s easy to get caught up in [gee-whiz cryptography](http://xkcd.com/538/) and miss fundamentals: you ultimately have to [trust something](http://cm.bell-labs.com/who/ken/trust.html "“Reflections on Trusting Trust” is a fascinating read about the fundamentals of security."), especially with important matters. SecretSplitter provides a trust circuit breaker just in case (because even well-meaning people can [lose](http://abcnews.go.com/WN/president-bill-clinton-lost-nuclear-codes-office-book/story?id=11930878 "Like the nuclear biscuit") [important things](http://www.theatlantic.com/politics/archive/2010/10/why-clintons-losing-the-nuclear-biscuit-was-really-really-bad/65009/ "Thankfully it wasn’t needed")). The splitting process adds a bit of complexity, but so do real circuit breakers. If you trust no one, then you can’t have anyone help you if something happens.

For demonstration purposes, let’s say you trust 3 people.

You now have to distribute these secret pieces. You could do all sorts of clever things like [send letters to people that will be delivered far in the future](http://www.hulu.com/watch/24493/back-to-the-future-part-ii-letter-from-doc "Like Doc did to Marty in “Back to the Future III”") or read them over the phone. However, distributing them in person is a pretty good option:

[![Creating an envelope with a share](/assets/life-death-and-splitting-secrets/CreateShareEnvelope_576.JPG)](/assets/life-death-and-splitting-secrets/CreateShareEnvelope.JPG)

It can make the upcoming holiday table discussions even more fun:

[![Handing over the envelope with the secret piece](/assets/life-death-and-splitting-secrets/ShareHandoff_576.JPG)](/assets/life-death-and-splitting-secrets/ShareHandoff.JPG)

Let’s pretend that something happened to you. Two of the three family members that you gave pieces to would come together and agree that “something” indeed has happened to you. What happens now?

[![Two opened envelopes with secret shares](/assets/life-death-and-splitting-secrets/TwoEnvelopesOpened_576.JPG)](/assets/life-death-and-splitting-secrets/TwoEnvelopesOpened.JPG)

Well, either you included a note with each secret piece or you emailed them previously with instructions that they’d just need to download and run this small program. The pair comes together at a laptop and they each type their piece in quickly and then press “Recover”:

[![Typing in secret shares with a typo](/assets/life-death-and-splitting-secrets/RecoverMessageWithTypo_576.png)](/assets/life-death-and-splitting-secrets/RecoverMessageWithTypo.png)

Oops... they typed so quickly that they mixed up one of the digits. It told us where to look:

[![Warning about typo](/assets/life-death-and-splitting-secrets/RecoverMessageTypoWarning_576.png)](/assets/life-death-and-splitting-secrets/RecoverMessageTypoWarning.png)

They fix the typo and press recover again:

[![Fixed the typo](/assets/life-death-and-splitting-secrets/RecoverMessageTypoFixed_576.png)](/assets/life-death-and-splitting-secrets/RecoverMessageTypoFixed.png)

And immediately they see:

[![Recovered message](/assets/life-death-and-splitting-secrets/RecoveredMessage_576.png)](/assets/life-death-and-splitting-secrets/RecoveredMessage.png)

Password recovered! They could now use this master password to log into your password manager where you’ve stored further details.

This “message” approach is useful if you have a small amount of data such as a password that you could write on a piece of paper. One downside is that each piece is twice the size of the text message. If your message becomes much larger then it will no longer be feasible to type it in manually.

One alternative approach is to bundle together all of your important files into a zip file:

[![Example of a compressed file contents](/assets/life-death-and-splitting-secrets/CompressedFileExample_576.png)](/assets/life-death-and-splitting-secrets/CompressedFileExample.png)

To split this file, you’d click the “Create” tab and then find the file, set the number of shares and click “Save”:

[![Splitting up a file](/assets/life-death-and-splitting-secrets/SplitFileSpecifyFileAndShares_576.png)](/assets/life-death-and-splitting-secrets/SplitFileSpecifyFileAndShares.png)

You’ll then be told:

[![MessageBox asking you to save the file](/assets/life-death-and-splitting-secrets/SplitFileSaveMessageBox_576.png)](/assets/life-death-and-splitting-secrets/SplitFileSaveMessageBox.png)

And then you pick where to save the encrypted file:

[![Save file dialog](/assets/life-death-and-splitting-secrets/SplitFileSaveDialog_576.png)](/assets/life-death-and-splitting-secrets/SplitFileSaveDialog.png)

Finally, you’ll see this screen:

[![Split file pieces](/assets/life-death-and-splitting-secrets/SplitFileShares_576.png)](/assets/life-death-and-splitting-secrets/SplitFileShares.png)

This creates a slightly more complicated scenario because you now have 2 things to share: the secret pieces and the encrypted file with all your data. The encrypted file doesn’t have to be secret at all. You can safely email it to people that have a secret piece:

[![Sending the fun email](/assets/life-death-and-splitting-secrets/SplitFileEmail_576.png)](/assets/life-death-and-splitting-secrets/SplitFileEmail.png)

Now, if something happens to you, they’d run the program, and type in two shares and press “Recover”:

[![Entering in file shares](/assets/life-death-and-splitting-secrets/RecoverFileShares_576.png)](/assets/life-death-and-splitting-secrets/RecoverFileShares.png)

It’ll then tell them:

[![Specify encrypted file MessageBox](/assets/life-death-and-splitting-secrets/RecoverFileSpecifyEncryptedFileMessageBox_576.png)](/assets/life-death-and-splitting-secrets/RecoverFileSpecifyEncryptedFileMessageBox.png)

They’d then go to their email and search for the email from you that includes your encrypted file:

[![Searching email](/assets/life-death-and-splitting-secrets/RecoverEmailSearch_576.png)](/assets/life-death-and-splitting-secrets/RecoverEmailSearch.png)

Then they’d find the single message (or the latest one if you sent out updates) and download your encrypted attachment:

[![Found email](/assets/life-death-and-splitting-secrets/RecoverEmailFound_576.png)](/assets/life-death-and-splitting-secrets/RecoverEmailFound.png)

They’d then go back to the program to open it up:

[![Opening the file](/assets/life-death-and-splitting-secrets/RecoverFileOpen_576.png)](/assets/life-death-and-splitting-secrets/RecoverFileOpen.png)

and then they’d see a message to be careful where they saved it:

[![Will you keep the data safe?](/assets/life-death-and-splitting-secrets/RecoverFileSafetyWarning_576.png)](/assets/life-death-and-splitting-secrets/RecoverFileSafetyWarning.png)

and then they’d save it:

[![Save decrypted](/assets/life-death-and-splitting-secrets/SaveDecryptedFile_576.png)](/assets/life-death-and-splitting-secrets/SaveDecryptedFile.png)

They'd then be asked if they want to open the decrypted file, which they’d say “Yes”:

[![Open decrypted file?](/assets/life-death-and-splitting-secrets/RecoverFileOpenDecryptedFileMessageBox_576.png)](/assets/life-death-and-splitting-secrets/RecoverFileOpenDecryptedFileMessageBox.png)

Now they can see everything:

[![Example of a compressed file contents](/assets/life-death-and-splitting-secrets/CompressedFileExample_576.png)](/assets/life-death-and-splitting-secrets/CompressedFileExample.png)

It might sound complicated, but if you’re familiar with the process, it might only take a minute. If you’re not tech savvy and have never done it before and type slowly, it might take 30 minutes. In either case, it’s faster than having to drive to your home and search around for a folder and it contains everything you wanted people to know (especially when things are time sensitive).

That’s it! Your master password and important data are now backed up. The risk is distributed: if any one piece is compromised (i.e. gets lost or misplaced), you can have everyone else destroy their secret piece and nothing will be leaked. Also, the program has an advance feature that lets you save the file encryption key. This feature allows you to send out updated encrypted files that can be decrypted with the pieces you’ve already established in person.

SecretSplitter implements a “(t,n) [threshold cryptosystem](http://en.wikipedia.org/wiki/Threshold_cryptosystem)” which can be thought of as a mathematical generalization of the physical two-man rule. The idea is that you split up a secret into pieces (called “shares”) and require at least a threshold of “t” shares to be present in order to recover the secret. If you have less than “t” shares, you gain no information about the secret. Whatever threshold you use, it’s really important that each “shareholder” know the threshold number of shares.

You can be quite creative in setting the threshold and distributing shares. For example, you can trust your spouse more by giving her more shares than anyone else. The key idea is that **a share is an atomic unit of trust**. You can give more than one unit of trust to a person, but you can never give less.

Another important practical concern is that you should consider adding redundancy to any threshold system. This is easily achieved by creating more shares than the threshold number. The reason is that if you’re going out of your way to use a threshold system, then you probably want to make sure you have a backup plan in case one or more of the shares are unavailable.

**IMPORTANT LEGAL NOTE**: It’s tempting to keep everything, including the important directives and your will in only electronic form (even when they’re signed). Unfortunately, most states require the original signed documents to be considered legal and most courts will not accept a copy. For this reason, you should still have the paper originals somewhere such as a fireproof safe. However, be careful where you put the originals: although it might sound convenient to put them in a bank safety deposit box, there’s usually a rather long waiting period before a before a bank can legally provide access to your box to a survivor, so don’t put any time sensitive items there. My recommendation at the current time would be to include copies of the signed originals in your encrypted file and also include detailed instructions on where the originals are located and how to access them.

## How It Works

Given the sensitive nature of the data being protected, I wanted to make sure I understood every part of the mathematics involved and literally every bit of the encrypted file. You’re more than welcome to just use the program without fully understanding the details, but I encourage people to verify my math and code if you’re able and curious.

To get started, recall that computers work with [bits](http://en.wikipedia.org/wiki/Bit): 1’s and 0’s that can represent anything. For example, the [most popular way of encoding text](http://en.wikipedia.org/wiki/UTF-8) will encode “thunder” in binary as

01110100 01101000 01110101 01101110 01100100 01100101 01110010

We can write this more efficiently using [hexadecimal](http://en.wikipedia.org/wiki/Hexadecimal) notation as: 74 68 75 6E 64 65 72. We can also treat this entire sequence of bits as a single 55 bit number whose decimal representation just happens to be 32,765,950,870,971,762. In fact, *any* piece of data can be converted to a single number.

Now that we have a single number, let’s go back to your algebra class and remember the equation for a <a href="http://en.wikipedia.org/wiki/Line_(geometry)">line</a>:  y=mx+b.

[![Line showing intercept](/assets/life-death-and-splitting-secrets/LineShowingIntercept_576.png)](/assets/life-death-and-splitting-secrets/LineShowingIntercept.png)

In this equation, “b” is the “[y-intercept](http://en.wikipedia.org/wiki/Y-intercept)”, which is where the line crosses the y-axis. The “m” value is the [slope](http://en.wikipedia.org/wiki/Slope) and represents how steep the line is (i.e. its “<a href="http://en.wikipedia.org/wiki/Grade_(slope)">grade</a>” if it were a hill).

This is all the core math you need to understand splitting secrets. In our particular case, our secret message is always represented by the y-intercept (i.e. “b” in y=mx+b). We want to create a line that will go through this point. Recall that a line could go through this point at any angle. The slope (i.e. “m” in y=mx+b) will direct us where it goes. For things to work securely, the slope must be a random number.

Although we use large numbers in practice for security reasons, let’s keep it simple here. Let’s say our secret number is “7” and our random slope is “3.” These choices generate this line:

[![y=3x+7](/assets/life-death-and-splitting-secrets/Line3xp7_576.png)](/assets/life-death-and-splitting-secrets/Line3xp7.png)

With this equation, we can generate an infinite number of points on the line. For example, we can pick the first three points: (1, 10), (2, 13), and (3, 16):

[![3 points](/assets/life-death-and-splitting-secrets/Line3points_576.png)](/assets/life-death-and-splitting-secrets/Line3points.png)

You can see that if you had any two of these points, you could find the y-intercept.

It’s critical to realize that having just one of these points gives us no useful information about the line. However, having any other point on the line would allow us to use a ruler and draw a straight line to the y-intercept and thus reveal the secret (we could also work it out algebraically). Each point represents a secret piece or “share” and has a unique “x” and “y” value.

The mathematically fascinating part about this idea is that a line is just a simple [polynomial](http://en.wikipedia.org/wiki/Polynomial) (curve) and this technique works for polynomials of arbitrarily large [degrees](http://en.wikipedia.org/wiki/Polynomial#Degree). For example, a second degree polynomial is a [parabola](http://en.wikipedia.org/wiki/Parabola) that requires 3 unique points to completely define it (one more than a line). Its equation is of the form y=ax^2 + bx + c. In our case “c” is the y-intercept and “a” and “b” are random as in y = 2x^2 + 3x + 7:

Given this equation, we can generate as many “shares” as we’d like: (1,12), (2,21), (3,34), (4,51), etc.

Keep in mind that a parabola requires three points to uniquely define it. If you just had two points, as in (1,12) and (2,21), you could create an infinite number of parabolas going through these points and thus have infinite choices for what the y-intercept (i.e. your secret) could be:

[![6 parabolas going through the same two points](/assets/life-death-and-splitting-secrets/Parabola6Curves_576.png)](/assets/life-death-and-splitting-secrets/Parabola6Curves.png)

However, a third point will define the parabola and its y-intercept exactly:

[![Unique parabola](/assets/life-death-and-splitting-secrets/ParabolaSingleCurve_576.png)](/assets/life-death-and-splitting-secrets/ParabolaSingleCurve.png)

You’ve just learned that splitting a secret that requires three people is just a matter of creating a parabola. Requiring more people is just a matter of creating a higher-degree polynomial such as a [cubic](http://en.wikipedia.org/wiki/Cubic_function) or [quartic](http://en.wikipedia.org/wiki/Quartic_function) polynomial. If you understand this basic idea, the rest is just details:

1.  Instead of using numbers, we translate the data to a big polynomial <a href="http://en.wikipedia.org/wiki/GF(2)">with binary coefficients</a>.
2.  Instead of using middle school algebra, we use a “[finite field](http://en.wikipedia.org/wiki/Finite_field).” This helps keep results about the same size as the input and adds some security.

Don’t be intimidated by these changes. The core ideas are the same as the basic case. The only noticeable difference is that you have to think of operations like multiplication and division in a more abstract way. For details, check out my source code’s use of [Horner’s scheme](https://github.com/moserware/SecretSplitter/blob/1b54b72a87d4bdcc5c84b12b36f17fca382d551d/SecretSplitter/Algebra/FiniteFieldPolynomial.cs#L40) for evaluating polynomials, [peasant multiplication](https://github.com/moserware/SecretSplitter/blob/1b54b72a87d4bdcc5c84b12b36f17fca382d551d/SecretSplitter/Algebra/FiniteFieldPolynomial.cs#L63), [irreducible polynomials](https://github.com/moserware/SecretSplitter/blob/1b54b72a87d4bdcc5c84b12b36f17fca382d551d/SecretSplitter/Algebra/IrreduciblePolynomial.cs#L12) [with the fewest terms](http://math.stackexchange.com/questions/14787/finding-irreducible-polynomials-over-gf2-with-the-fewest-terms), [Lagrange polynomial interpolation](https://github.com/moserware/SecretSplitter/blob/1b54b72a87d4bdcc5c84b12b36f17fca382d551d/SecretSplitter/Algebra/LagrangeInterpolator.cs#L22) to find the y-intercept, and using [Euclidean inverses](https://github.com/moserware/SecretSplitter/blob/1b54b72a87d4bdcc5c84b12b36f17fca382d551d/SecretSplitter/Algebra/FiniteFieldPolynomial.cs#L106) for division.

Again, it probably sounds more complicated than it really is. At its core, it’s simple. This technique is formally known as a [Shamir Secret Sharing Scheme](http://securespeech.cs.cmu.edu/reports/shamirturing.pdf "See “How to Share a Secret” by Adi Shamir") and it was discovered in the 1970’s.

I didn’t want to invent anything new unless I felt I absolutely had to. There was already a good tool called “[ssss-split](http://point-at-infinity.org/ssss/)” that generates shares similar to how I wanted. This program adds a special twist by scrambling the resulting y-intercept point and therefore adds an extra layer of protection. Since this program was already the de-facto standard, I wanted to be fully compatible with it. To make sure I was compatible, I had to copy its method of “diffusing” (i.e. scrambling) the bits using the public domain [XTEA algorithm](http://en.wikipedia.org/wiki/XTEA). However, to ensure complete fidelity, I had to look at the source code. The only problem was that it was originally released under the [GNU Public License](http://www.gnu.org/copyleft/gpl.htmlhttp://www.gnu.org/copyleft/gpl.html) (GPL) and it used [a GPL library for working with large numbers](http://en.wikipedia.org/wiki/GNU_Multiple_Precision_Arithmetic_Library). My goal was to make my implementation as open as I could, so I asked the author if I could look at his code to derive my own implementation that I’d release under the more permissive [MIT license](http://www.opensource.org/licenses/mit-license.php) and he graciously allowed me to do this.

To prove the compatibility, you can use the [ssss-split demo page](http://point-at-infinity.org/ssss/demo.html) and paste the results [into SecretSplitter](https://github.com/moserware/SecretSplitter/releases/latest) and it’ll work just fine. In addition, I [created command line programs from scratch](https://github.com/moserware/SecretSplitter/releases) that are fully compatible with ssss-split and ssss-combine.

After some basic usability testing, I decided to make one small adjustment. The “ssss-split” command allows you to attach a prefix that it ignores. I wanted to add a special prefix that would tell what type of share it was (i.e. a message or a file) as well as a [simple checksum](http://en.wikipedia.org/wiki/SHA-1) because with all those digits it’s easy to mistype one.

Now, you can understand all the pieces of the long share:

[![Share components](/assets/life-death-and-splitting-secrets/ShareComponents_576.png)](/assets/life-death-and-splitting-secrets/ShareComponents.png)

In theory, you could “encrypt” a large file directly using this technique. In practice, it doesn’t work well because each share would be huge and not something you’d be able to write down by hand or say over the phone, even using the [phonetic alphabet](http://en.wikipedia.org/wiki/NATO_phonetic_alphabet).

For lots of data, we use a hybrid approach: encrypt the file using standard file encryption with a random key and then split the small “key” into pieces.

For file encryption, I again didn’t want to invent anything new. I decided to use the [OpenPGP Message Format](http://tools.ietf.org/html/rfc4880), the same format used by [PGP](http://en.wikipedia.org/wiki/Pretty_Good_Privacy) and [GNU Privacy Guard](http://www.gnupg.org/) (GPG). I didn’t want to have to worry about licensing restrictions or including a [third-party library](http://www.bouncycastle.org/ "Like Bouncy Castle"), so I wrote my own implementation from scratch that did exactly what I wanted. I [read RFC4880](http://commondatastorage.googleapis.com/rhuang/rfc4880.mobi "I'm a bit embarrassed to admit I read it on my Kindle by the beach. On the subject, I must admit that RFC2MOBI is a great free app for converting text-based RFCs to Kindle MOBI files. It does a remarkably decent job.") and started sketching out what I needed to do. A few bug fixes later and I had a working implementation that was able to interoperate with GPG. To simplify my implementation, I only support a limited subset of features:

1.  I always use [AES](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard) with a 256-bit key for encryption, even if users select a smaller effective key size. This means that users can pick any size key they want and thus balance security and share length. I picked AES because it’s strong and [understandable with stick figures](http://www.moserware.com/2009/09/stick-figure-guide-to-advanced.html).
2.  The actual file encryption key is always a [hashed, salted, and stretched version](http://tools.ietf.org/html/rfc4880#section-3.7.1.3) of the reconstructed shares text.
3.  The encrypted file has an [integrity protection packet](http://tools.ietf.org/html/rfc4880#section-5.13) to detect if the file has been modified and ensure it was decrypted correctly.

Since I used common formats, you can verify the correctness of the generated files using a Linux shell. You can also create files using the shell and have them interoperate with SecretSplitter. I included [a sample of how to do this with the source code](https://github.com/moserware/SecretSplitter/blob/master/Compatibility.txt).

## Help Wanted / Future Possibilities

SecretSplitter still looks and feels like a prototype. There are lots of possible improvements that could be made:

1.  Secret splitting is a relatively complicated idea. In [Cryptography Engineering](http://www.amazon.com/gp/product/0470474246/ref=as_li_ss_tl?ie=UTF8&tag=moserware-20&linkCode=as2&camp=217145&creative=399369&creativeASIN=0470474246), the authors write “secret sharing schemes are rarely used because they are too complex. They are complex to implement, but more importantly, they are complex to administrate and operate.”

Although I tried to simplify the user experience for broad use, it could still use some user experience enhancements to simplify it further.
2.  I wrote it in C# for the .net platform because that is what I’m most familiar with (and it has some built-in powerful primitives like BigIntegers, AES, and hash functions). I suspect that an HTML5 version using JavaScript, a nice interface, and coming from a trusted domain would get much broader usage. In addition, since this is a problem that affects everyone, having great internationalization support would be a nice touch. It also would be nice to have a polished look with a good logo and other graphics.
3.  You could use more [elaborate secret sharing schemes](http://en.wikipedia.org/wiki/Verifiable_secret_sharing) than what I implemented in SecretSplitter. I considered these, but ultimately wanted to use a technique that was already compatible with widely deployed tools. I also considered enhancing shares with [two-factor](http://www.google.com/url?q=http%3A%2F%2Fen.wikipedia.org%2Fwiki%2FTime-based_One-time_Password_Algorithm&sa=D&sntz=1&usg=AFQjCNEG4XPPcQbdiivr7kuRUBxExU6Aqw) support or using [existing public key infrastructure](http://en.wikipedia.org/wiki/Public_key_infrastructure), but decided that added too much complexity. Perhaps it’s possible to incorporate these in a good design.
4.  It’d be neat if this scheme or something similar to it was integrated into LastPass and KeyPass as a core feature.
5.  Obviously the shares themselves are long. I tried making them shorter but the downsides outweighed the upsides. Perhaps it could be better. Also, a compelling graphically designed share card might make it more fun for broader use. The long length is somewhat of a safety mechanism that prevents people from memorizing with a quick glance. Also, it discourages overhasty use much like [freezing a credit card](http://vimeo.com/5735591 "Although, as this video demonstrates a hammer allows for quick access. However, at least you’d be making a conscious decision at that point.").
6.  I kept the codes in a format that would be easy to write as well as read over the phone. I used a simple character set that avoids ambiguities like “O” vs “0”. One additional strategy could be to embed the share as a [QR code](http://qrcodenet.codeplex.com/) or something similar. I didn’t pursue this approach in favor of simplicity, but this could be an option.
7.  Really paranoid people might want to back up their encrypted file to paper. [This is possible](http://www.codinghorror.com/blog/2009/07/the-paper-data-storage-option.html), but I’m not sure if it should belong inside the program itself.
8.  It’d be good to have suggestions on how to exchange shares or perhaps borrow ideas from PGP [key signing parties](http://en.wikipedia.org/wiki/Key_signing_party). I suspect that if secret splitting were to become popular, then “[web of trust](http://en.wikipedia.org/wiki/Web_of_trust)” scenarios would naturally occur (i.e. “I’ll hold your secret share if you hold mine”).
9.  It’d be fun to compile a list of non-obvious uses for SecretSplitter to share with others. For example, it could make for interesting scavenger hunt clues.

If you’d like to donate your time to any of the above ideas, I’d encourage you to just give it a go. You don’t have to ask for my permission but it would be nice if you posted your results somewhere or left a comment to this post. You can use my code for whatever purpose you’d like. My only hope is that you might get some benefit out of it.

## Conclusion

SecretSplitter is just a tool that gives another option for backing up very sensitive information by splitting it up into pieces. It’s not a full solution, only a tool. By relying on people I trust instead of [a third-party company](http://mashable.com/2010/10/11/social-media-after-death/ "Besides, I don't want to have to worry about a third-party company “dying” before I do."), it helped me remove one excuse I had for not preparing somewhat unpleasant but important documents that we should all probably have. I still don’t have this all figured out, but writing SecretSplitter help me get started.

If you’re young, don’t have any <a href="http://en.wikipedia.org/wiki/Minor_(law)">minor children</a>, and don’t care at all what happens to your stuff, then you could run some mental actuarial model and convince yourself that the probability of you or your survivors needing these documents or password recovery procedure anytime soon is low, but you’re not given any guarantees.

At the very least, it’s a good idea to make sure all of your financial assets and life insurance policies have a named beneficiary and at perhaps at least one alternate. You can also declare things like organ donor preferences on your driver’s license instead of making declarations in other documents. It’s also a good idea to have an “[ICE](http://en.wikipedia.org/wiki/In_case_of_emergency "In Case of Emergency")” entry in your cell phone. However, going the extra step and making very basic final documents doesn’t require that much more work. Besides, once you have baseline documents, keeping them fresh is just a matter of occasional updates due to life events.

The increasing digitization of our lives means that more personal things will only be stored digitally. From our journals to email to videos to health records, all of this will eventually only exist digitally and likely hidden behind passwords. This future needs some safety net for backing up sensitive things in a safe and accessible way.

Everything doesn’t need to be backed up. There are also lots of files, usernames and passwords that don’t really matter. Don’t include those. SecretSplitter was built with the assumption that everything that really mattered could be stored in a file small enough to email to others. This helps focus and pare down to what really matters.

It’s also good to have a healthy dose of common sense. Instead of holding out a secret until after your death, maybe you should get that resolved today. You’ll probably live better. My general view is that these final “secrets” should be mostly boring by just containing account details and credentials.

Finally, on a more personal level, I think it’s healthy to be reminded about our own mortality at least once every year or so. It’s a helpful reminder of how much a gift every day is and helps focus what we do and not worry about things that don’t matter.

If a little bit of fancy math can help you sleep better at night, well then, I’d consider it a success.

*Special thanks to B. Poettering for creating the original* [*ssss*](http://point-at-infinity.org/ssss/) *program and allowing me to clone its format.*