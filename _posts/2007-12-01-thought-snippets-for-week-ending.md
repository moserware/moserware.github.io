---
layout: post
title: "Thought Snippets for the Week Ending 12/1/2007"
date: 2007-12-01 09:54:00
updated: 2007-12-23 21:31:55
permalink: /2007/12/thought-snippets-for-week-ending.html
---
Here's the first of a perhaps weekly series of things that I thought were interesting in the past week, but are just too short to warrant a full post:

-   [Hanselminutes Episode #90](http://www.hanselminutes.com/default.aspx?showID=108) - "Software architects are there to make sure the project doesn't fail" and "[one should] architect for referrals." -   "[grep](http://en.wikipedia.org/wiki/Grep)" comes from the Unix program [ed](http://en.wikipedia.org/wiki/Ed_%28Unix%29) command of g/re/p which does a **g**lobal **r**egular **e**xpression search and **p**rints the results. I never knew this before 
-   I knew about the [GC.SuppressFinalize](http://msdn2.microsoft.com/en-us/library/system.gc.suppressfinalize.aspx) method to tell the garbage collector that an object shouldn't have its finalizers called, but while reading more about IL, I found out that there indeed is a [GC.ReRegisterForFinalize](http://msdn2.microsoft.com/en-us/library/system.gc.reregisterforfinalize.aspx) just in case you made a mistake :) 
-   Although it should have been insanely obvious, it wasn't until I saw in the IL that all methods of interfaces are indeed virtual. Although, in hindsight, it sorta makes sense.

**UPDATE**: After thinking about it for awhile, I've decided not to keep this series up on a weekly basis since that might generate too much noise.