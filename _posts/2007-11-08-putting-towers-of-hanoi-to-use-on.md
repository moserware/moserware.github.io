---
layout: post
title: "Putting the Towers of Hanoi to Use on Backups"
date: 2007-11-08 21:53:00
updated: 2007-11-08 22:05:48
permalink: /2007/11/putting-towers-of-hanoi-to-use-on.html
---
[![](/assets/putting-towers-of-hanoi-to-use-on/300px-Tower_of_Hanoi_4.gif)](http://en.wikipedia.org/wiki/Tower_of_hanoi)

I needed to regularly backup some data to a zip file in another directory. The problem was that the data changed daily and the size started to be an issue so that I couldn't keep all the backups.

So what files do you delete and when? Ideally, you'd like to be able to recover from most errors. This includes the error where something has been wrong for a month and you need to recover from that one as well. (It also includes the "OH NO! I DELETED HALF THE FILE!" errors where you need a very fresh copy).

After some searching, I stumbled across a rather clever solution that apparently some backup programs implement: use the optimal [Tower of Hanoi](http://en.wikipedia.org/wiki/Tower_of_hanoi) solution. If you recall, the Tower of Hanoi problem is typically stated where you have three poles and some discs of decreasing size. You need to move the stack of discs from one pole to another so that no bigger disc is ever on top of a smaller disc. One good solution is to always move the smallest disc every 2^1 moves, the next smallest disc every 2^2 moves, the third smallest every 2^3 moves, etc. The picture from Wikipedia above shows this quite well.

Imagine that the discs are backup tapes. Each time you "move" the tape represents when you perform a backup using that tape. It gives a nice exponential staggering which works pretty good in practice. Working with zip files is similar, just delete files that don't match the exponential factor (well, there is some rounding involved). The math works out because a file that is 8 days old was around at the 4 day mark and at the 2 day mark. However, a file that is 6 days old wouldn't make it because it isn't a power of two.

So imagine it's 11/8/2007. You'd have a directory of backups like this:

    BACKUP-20071108.ZIP 
    BACKUP-20071107.ZIP 
    BACKUP-20071106.ZIP 
    BACKUP-20071104.ZIP 
    BACKUP-20071031.ZIP 
    BACKUP-20071023.ZIP 
    BACKUP-20071007.ZIP
    etc..

Recent history is very backed up, but it thins out over time where it becomes less useful. It's a nice trade off of having backups, but saving space.

Who knew? The Towers of Hanoi are actually *useful!*