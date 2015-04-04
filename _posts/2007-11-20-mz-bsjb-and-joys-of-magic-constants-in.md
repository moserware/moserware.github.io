---
layout: post
title: "MZ, BSJB, and the Joys of \"Magic\" Constants in Managed Assemblies."
date: 2007-11-20 20:32:00
updated: 2008-12-11 00:10:32
permalink: /2007/11/mz-bsjb-and-joys-of-magic-constants-in.html
---
![](/assets/mz-bsjb-and-joys-of-magic-constants-in/MZ.png)]

When I was 10 or so, I thought you could open up a .EXE in a text editor and do meaningful work with it if you only knew some magical secret. I noticed that all EXEs started with the letters "MZ" as in the CMD.EXE example above, but that's as far as I got.

A few years later, I read [this article](http://www.byte.com/art/9509/sec7/art25.htm) in the special 20th anniversary edition of Byte Magazine that let me know that "MZ" stood for the initials of [Mark Zbikowski](http://en.wikipedia.org/wiki/Mark_Zbikowski) who designed the MS-DOS executable file format. Needing *some* magic number to identify bits as an executable, what better choice than your own initials (in Mark's case 0x4D5A)? This is actually very [common knowledge](http://en.wikipedia.org/wiki/EXE) that won't get you points at your next nerd dinner.

However, today I will share a point generating piece of knowledge (well for at least a year or so)... Without further ado:

![](/assets/mz-bsjb-and-joys-of-magic-constants-in/BSJB.png)

In every piece of managed code, you'll find the four bytes (little-endian DWORD) of 0x42534A42, (of course, in big-endian 0x424A534A). This corresponds to the start of the "General Metadata Header" of an assembly.

The initials correspond to [**B**rian Harry](http://blogs.msdn.com/bharry/), **S**usan Radke-Sproull, [**J**ason Zander](http://blogs.msdn.com/jasonz/), and **B**ill Evans who were part of the team in 1998 that worked on the CLR.

I discovered this gem while reading [page 76](http://books.google.com/books?id=oAcCRKd6EZgC&pg=PA76&lpg=PA76&dq=bsjb+signature&source=web&ots=KyYeaCsTau&sig=6RsOPQSjT1REDjDoWBbg0DSJWR0) of [Expert .NET 2.0 IL Assembler](http://www.amazon.com/exec/obidos/ASIN/1590596463). After googling for it though it appears that it's been [covered elsewhere](http://safari.oreilly.com/0201770180/prf04) too.

With this knowledge, you could write a very simple program that checked to see if a file was a .NET assembly by looking for a start of "MZ" that also contained "BSJB." It looks like [the first "virus" that targeted .NET](http://www.peterszor.com/donut.pdf) took advantage of this fact.

Now, where can I put "JDM"?