---
layout: post
title: "What Does It Take To Become A Grandmaster Developer?"
date: 2008-03-03 07:37:00
updated: 2009-01-02 19:09:02
permalink: /2008/03/what-does-it-take-to-become-grandmaster.html
---
See how much of the following sequences of letters and numbers you can memorize in the next 20 seconds:

-   T, E, X, A, S, O, H, I, O, V, E, R, M, O, N, T, R, H, O, D, E, I, S, L, A, N, D 
-   2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41

Done yet?

Now, imagine that you were blindfolded and asked to recite them to someone else.

How well do you think you would do?

You'd probably be in one of these six groups:

![](/assets/what-does-it-take-to-become-grandmaster/memoryrecall3dbarswithlabels.png)]

Group 1 would get perfect recall without too much effort while Group 6 would really struggle to get a measly 20% recall. An interesting observation is that this wide range in results wouldn't be largely affected by the general memory abilities of the person. That is, the results are ***not*** based on innate or raw talent.

What's happened?

People in Group 1 didn't read the first sequence letter by letter. Somehow the words "TEXAS", "OHIO", "VERMONT", and "RHODE ISLAND" just jumped out to them because they recognized them as states in the USA. Then in the next flash of insight, they might have noticed the states are listed from largest to smallest in terms of area. Some might have even picked out that these are the states involved in the upcoming presidential primaries on Tuesday.

When approached with the number sequence, they might have read the first few numbers and then realized it was a list of [prime numbers](http://en.wikipedia.org/wiki/Prime_number) up to 41.

When asked to memorize it, they stored something like this in their mind:

`SELECT [LettersInWord] FROM [StatesInUpcomingPrimary] ORDER BY [StateSize]` which has 3 "chunks" to remember.

The second might have been stored as

`SELECT [Number] FROM [PrimeNumbers] WHERE [Number] <= 41` which also has about 3 "chunks."

All told, people in Group 1 had to consciously remember about 6 "chunks" of information. That's less numbers than a typical telephone number contains and it's what led to the perfect recall.

People in Group 6 probably took a much different approach. They might have just seen the sequences as a random collection of letters and numbers. Maybe they live in a country far away from the USA; maybe their native language is Chinese. To them, every letter and number was its own "chunk." When asked to remember the sequences, they might have been able to successfully recall 7-8 of these small "chunks."

That is, the people who remembered *less overall information* actually remembered *more "chunks*!" So in terms of "raw memory talent," Group 6 won even though they remembered only 20% of what Group 1 perfectly recalled.

Essentially Group 1 had a more efficient "<a href="http://en.wikipedia.org/wiki/Chunking_(psychology)">chunking</a>" algorithm.

## Chunking

When talking about the mind of a chess grandmaster, [Philip Ross writes](http://www.sciam.com/article.cfm?chanID=sa006&colID=1&articleID=00010347-101C-14C1-8F9E83414B7F4945):

> "When confronted with a difficult position, a weaker player may calculate for half an hour, often looking many moves ahead, yet miss the right continuation, whereas a grandmaster sees the move immediately, without consciously analyzing anything at all. 

> By measuring the time it takes to commit a new chunk to memory and the number of hours a player must study chess before reaching grandmaster strength, Simon estimated that a *typical grandmaster has access to roughly 50,000 to 100,000 chunks of chess information*. A grandmaster can retrieve any of these chunks from memory simply by looking at a chess position, in the same way that most native English speakers can recite the poem 'Mary had a little lamb' after hearing just the first few words 

> The one thing that all expertise theorists agree on is that it takes enormous effort to build these structures in the mind. Simon coined a psychological law of his own, the 10-year rule, which states that it takes approximately a decade of heavy labor to master any field. Even child prodigies, such as Gauss in mathematics, Mozart in music and Bobby Fischer in chess, must have made an equivalent effort, perhaps by starting earlier and working harder than others.

Thus the first thing we learn about mastery is that it takes a lot of "chunks" (approximately 50,000 - 100,000) to get there.

## Rating Systems

The next advantage that other fields have is a generally accepted rating system. Chess students can look at [FIDE](http://www.fide.com/) [ELO chess ratings](http://en.wikipedia.org/wiki/Comparing_top_chess_players_throughout_history) to see which people to study:

![](/assets/what-does-it-take-to-become-grandmaster/fideratings.png)]

Golf has its "[Official World Golf Rankings](http://en.wikipedia.org/wiki/Official_World_Golf_Rankings):"

![](/assets/what-does-it-take-to-become-grandmaster/golfrankings.png)]

But what about developers? What would be the inputs into the rating algorithm? It's hard to make good comparisons in our industry, especially when we like to hide [our failures](http://www.codinghorror.com/blog/archives/000588.html). Still, there are some reasonable categories to look at. Sonnentag, Niessen, and Volmer [give a reasonable first approximation](http://books.google.com/books?id=voWlHWw980UC&pg=PP392&dq=%22expertise+in+software+design%22&ei=Q5XJR6bpCKiWiQGupvwI&sig=vNaKquO0K4qvRM5Qm6wcJAyOVYI "If nothing else, read the summary chart on page 376") of what the input categories might be along with some interesting observations:

1.) Requirements Analysis and Design Tasks

> "A common assumption is that the decomposition process is guided by a knowledge representation, which is built up with experience and stored in long-term memory. When such a knowledge representation is not available, experts develop plans through a bottom up, backward strategy 

> ... 

> When software designers were asked about strategies they would recommend to an inexperienced programmer working on the same design problem, high performers reported twice as many strategies as moderate performers... experienced programmers did not necessarily have more plans available, but focused on the most salient parts of the plan and flexibly switched between plans. In contrast, novices preferred a strategy with which plans are implemented in a more linear fashion"

2.) Programming and Program Comprehension

> "... poorer performers exclusively focused on program terms *or* on domain terms without building connections between the two 'worlds.' Thus, it seems that connecting various domains and relating them to each other is a crucial for arriving at a comprehensive understanding of the program and the underlying problem. "

3.) Testing and Debugging

> "A thinking-aloud study showed that high performers needed less time for debugging, made fewer errors, searched more intensively for problems, and showed more information evaluation activity. Thus, it seems that high performers have a better representation of the program and potential problems, which helps them to actively search for problems and to evaluate information.

4.) Knowledge Representation and Recall

> "Professional programmers' [metacognitive](http://en.wikipedia.org/wiki/Metacognition) knowledge was much more detailed and more comprehensive than students' knowledge. For example, a professional programmer provided a comment such as 'The main program is not very well divided; the logic has been scattered over different parts of the program; the updating paragraph has too much in it. The control function of the program should be implemented in one paragraph; now the program has much depth in itself and scanning is difficult", whereas the students' comments were more general and diffuse."

5.) Communication and Cooperation

> "... exceptional software designers showed superior communication skills. In fact, much of the exceptional designers' design work was accomplished while interacting with other team members. High performers spent a lot of time educating other team members about the application domain and its mapping into computational structures... They found that individual performance of software developers is facilitated significantly by a 15-minute talk with a senior designer about their task. These results hold for complex tasks, not just for simple ones, indicating that high task complexity makes it more necessary and more valuable for the programmer to communicate with a more senior person."

I don't know how all of this would boil down to a mathematical formula to give a decent numeric rating. But this deficiency doesn't matter too much. Just thinking about how to improve in each of the 5 areas mentioned above could probably go a long way.

## Effects on Code

Is all of this discussion putting us into a mental [ivory tower](http://en.wikipedia.org/wiki/Ivory_tower)? Does it offer help to a developer whose boss is frustrated and fervently asking "[Why isn't someone coding yet (WISCY)?](http://www.dtic.mil/ndia/2004cmmi/CMMIT2Thur/1109Gross.pdf)" I think there is great potential. It all depends on how efficient you make your chunking algorithm. Moreover, you have to be careful.

[Spolsky writes](http://www.joelonsoftware.com/items/2005/10/17.html):

> A very senior Microsoft developer who moved to Google told me that Google works and thinks at a higher level of abstraction than Microsoft. "Google uses Bayesian filtering the way Microsoft uses the **if** statement," he said.

A foolish application of this statement would be to believe that you could exclusively live at the higher levels without understanding the lower levels. Chunking works effectively via hierarchical storage. Chunks [stand on the shoulders](http://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants) of other chunks. I can guarantee you that star Googlers understand "if" statements and almost everything below that level very well. In a world of [leaky abstractions](http://www.joelonsoftware.com/articles/LeakyAbstractions.html), you typically have no choice, as [Anders](http://en.wikipedia.org/wiki/Anders_Hejlsberg) says, but to "*add* another level of abstraction." Early on, I thought it was always possible to "raise the level of abstraction." I was wrong. Abstraction is important to effective chunking, but it still requires that you have solid lower level chunks to build on top of do well. This is especially true when problems arise and you have to debug.

Another technique is [giving meaningful names](http://www.hanselman.com/blog/TheWeeklySourceCode7.aspx) to chunks will often yield good results. For example, chess grandmasters [Bobby Fischer](http://en.wikipedia.org/wiki/Bobby_Fischer) and [Gary Kasparov](http://en.wikipedia.org/wiki/Garry_Kasparov) both won important tournament games using the "[King's Indian Attack](http://en.wikipedia.org/wiki/King%27s_Indian_Attack)" opening move. Developers can copy this tactic. You might chunk this:

![](/assets/what-does-it-take-to-become-grandmaster/syncrootvariation.png)]

as the "[SyncRoot](http://msdn2.microsoft.com/en-us/library/system.collections.arraylist.syncroot.aspx) Variation with [CompareExchange](http://msdn2.microsoft.com/en-us/library/system.threading.interlocked.compareexchange.aspx) Cheap Locking."

Chunking this:

![](/assets/what-does-it-take-to-become-grandmaster/onelinesingleton.png)]

could be as simple as "One Line [Singleton](http://en.wikipedia.org/wiki/Singleton_pattern)" which is much easier to chunk than the roughly equivalent "Thread-safe Lazy Loading Singleton:"

![](/assets/what-does-it-take-to-become-grandmaster/singletonthreadsafelazyloading.png)]

Instead of "Array Sum via Classic [For Loop](http://www.moserware.com/2008/02/for-loops-using-i-i-enumerators-or-none.html) Iteration:"

![](/assets/what-does-it-take-to-become-grandmaster/primesumforloop.png)]

you could have "Array Sum Using LINQ":

![](/assets/what-does-it-take-to-become-grandmaster/primessumlinq.png)]

The latter is in line with Anders' [recent statement](http://www.langnetsymposium.com/talks/1-01%20-%20CSharp3%20-%20Anders%20Hejlsberg.html) that future versions of C# will be about getting the programmer to declare "more of the what, and less of the how" with respect to how a result gets computed. A side effect of this is that your "chunks" tend to be more efficient for the runtime, and more importantly, your brain.

The code examples so far have been fairly straightforward given their names. Some people might be saying that "you're just calling 'chunks' what are called ['design patterns](http://en.wikipedia.org/wiki/Design_Patterns)' or even '[micropatterns](http://portal.acm.org/citation.cfm?doid=1103845.1094819)'." To this, I would respond "not exactly." For example, even though I had heard of the [principle of least privilege](http://en.wikipedia.org/wiki/Principle_of_least_privilege), it wasn't until I saw a [code snippet from Jeremy Miler](http://codebetter.com/blogs/jeremy.miller/articles/131726.aspx) that I realized you could be extra precise when defining an immutable class:

![](/assets/what-does-it-take-to-become-grandmaster/internalclasscustomer.png)]

Reading Jeremy's code effectively enriched my definition of an "immutable class" chunk to have even more attributes of "least privilege." I didn't see this a year ago.

I have a long way to go, but I think that one aspect of being able to quickly churn out great code is by having a huge reservoir of chunks like I mentioned above. The good news is that you don't have to remember the syntax. You can quickly recreate it from the idea or name. I think the benefit you get is nearly the same as chess students get from specifically named moves.

## Effects on Hiring

One interesting playground for chunking is interviewing people. Developer interviews should always include some sort of "chunking" test at the [FizzBuzz](http://tickletux.wordpress.com/2007/01/24/using-fizzbuzz-to-find-developers-who-grok-coding/) level or higher.

Simple chunks like conditional statements, loops, pointers, and recursion should be almost as effortless as breathing. As Spolsky [wrote](http://www.joelonsoftware.com/articles/GuerrillaInterviewing3.html):

> "If the basic concepts aren’t so easy that you don’t even have to think about them, you’re not going to get the big concepts... You see, if you can’t whiz through the easy stuff at 100 m.p.h., you’re never gonna get the advanced stuff."

Any modern business program is inherently complicated on its own. Since a typical person can only keep "[7 plus or minus 2](http://www.musanim.com/miller1956/)" chunks in their head at once, it's imperative that they are good sized chunks in order to [get things done](http://www.joelonsoftware.com/articles/GuerrillaInterviewing3.html).

Instead of looking for "years of experience," it'd be nice if there was something better like "years actively pursuing developer grandmaster status," but that's a *bit* of a stretch to ask for.

## Four Stages of Chunk Competence

Each one of the 50,000+ chunks on the way mastery will probably go through the [four stages of competence](http://en.wikipedia.org/wiki/Four_stages_of_competence). Here's a concrete example:

1.  **Unconscious incompetence** - 10 years ago, I never even *thought* about software running in [Turkey](http://en.wikipedia.org/wiki/Turkey), let alone any issues that might come up there.
2.  **Conscious incompetence** - 5 years ago, I finally came to understand [the basics](http://www.joelonsoftware.com/articles/Unicode.html) about [Unicode](http://en.wikipedia.org/wiki/Unicode) and [internationalization](http://en.wikipedia.org/wiki/Internationalization_and_localization) and realized that my code wouldn't work quite right, but I didn't know how to best handle it.
3.  **Conscious competence** - 2 years ago, with the help of [FxCop](http://en.wikipedia.org/wiki/FxCop), I learned how to [correctly handle](http://msdn2.microsoft.com/en-us/library/ms182189.aspx) character comparison in .net, but only recently learned how to [correctly handle parsing and formatting locale specific information](http://msdn2.microsoft.com/en-us/library/ms182190.aspx).
4.  **Unconscious competence** - I'm not there yet, but I wouldn't be surprised if I produce some painful facial expression when I see a zero parameter ".[ToLower](http://msdn2.microsoft.com/en-us/library/e78f86at.aspx)()" call in code due to the potentially bad side effects I've experienced from its use.

The progression above is what led me to devise "[The Turkey Test](http://www.moserware.com/2008/02/does-your-code-pass-turkey-test.html)." It was a long process. That is probably typical for any reasonable sized chunk. I'm assuming that chunk acquisition has the following learning curve:

![](/assets/what-does-it-take-to-become-grandmaster/competenceplot.png)]

The good news is that it's [relatively easy to make fast initial improvements if you're "deliberately focused"](http://davidseah.com/blog/building-a-niche-of-one/) which requires a high conscious effort. The bad news is that mastering the chunk takes a long time. Even worse, you might never even start if you stick to only the things you already know.

Reading good blogs, books, or papers can help. But the best resource by far is an environment where coworkers can safely rocket you through the above learning curve. This is why I really value intense code reviews by my peers at work. Good critiques have let me accelerate my learning process as a result and get slightly better. It's just simply way more efficient that way. It'd sort of be like the young [Gary Kasparov](http://en.wikipedia.org/wiki/Garry_Kasparov) playing a game with [Bobby Fischer](http://en.wikipedia.org/wiki/Bobby_fischer) and getting beaten badly. It'd hurt the pride initially, but it would probably help him learn much faster than reading books (as long as he kept good notes of the game).

## Is There Hope?

You want to [hit the high notes](http://www.joelonsoftware.com/articles/HighNotes.html) and be a [level 5 expert](http://www.codinghorror.com/blog/archives/000203.html) developer. These are actually reasonable goals. But you need to be realistic. If the 50,000+ chunk number is required to be an expert, it takes *a lot* of time. Realize that [even after a decade of being a focused programmer, you're still just a teenager](http://steve-yegge.blogspot.com/2008/02/portrait-of-n00b.html). Like a large number of you, I started "dabbling with computers" when I was a kid. If you count my first [Applesoft BASIC](http://en.wikipedia.org/wiki/Applesoft_BASIC) program as experience, then I have 17 years of experience. But I have a *long* way to go.

Don't get me wrong, I agree that raw "[years of experience](http://www.codinghorror.com/blog/archives/001054.html)" is a myth.

My problem is that I haven't been as focused as I could have been. I only realized that after diving into "chunking." [John Cloud summarizes things well](http://www.time.com/time/health/article/0,8599,1717927-2,00.html):

> "Ericsson's primary finding is that rather than mere experience or even raw talent, it is dedicated, slogging, generally solitary exertion — repeatedly practicing the *most difficult physical tasks* for an athlete, *repeatedly performing new and highly intricate computations for a mathematician — that leads to first-rate performance*. ***And it should never get easier; if it does, you are coasting, not improving***. Ericsson calls this exertion "*deliberate practice*," by which he means *the kind of practice we hate, the kind that leads to failure and hair-pulling and fist-pounding*. You like the Tuesday New York Times crossword? You have to tackle the Saturday one to be really good 

> Take figure-skating. For the 2003 book Expert Performance in Sports, researchers Janice Deakin and Stephen Cobley observed 24 figure skaters as they practiced. Deakin and Cobley asked the skaters to complete diaries about their practice habits. The researchers found that *elite skaters spent 68% of their sessions practicing jumps — one of the riskiest and most demanding parts of figure-skating routines*. Skaters in a second tier, who *were just as experienced in terms of years*, spent only 48% of their time on jumps, and they rested more often. As Deakin and her colleagues write in the Cambridge Handbook, "All skaters spent considerably more time practicing jumps that already existed in their repertoire and less time on jumps they were attempting to learn." In other words, ***we like to practice what we know***, stretching out in the warm bath of familiarity rather than stretching our skills. *Those who overcome that tendency are the real high performers*." (Emphasis added)

That's probably one of the most truthful statements about improving that exists. The only thing I would clarify is that your *conscious chunks* shouldn't be getting easier; the chunks that were foggy in your conscious mind should probably get easier as they drift to your unconscious mind. However, you must refuse to coast. It's about picking chunks "[not because they are easy, but because they are hard](http://en.wikisource.org/wiki/We_choose_to_go_to_the_moon)."

The way to the top is filled with [things getting harder](http://www.quoteworld.org/quotes/4219). There are [no shortcuts](http://info.computer.org/portal/site/computer/menuitem.eb7d70008ce52e4b0ef1bd108bcd45f3/index.jsp?&pName=computer_level1&path=computer/homepage/misc/Brooks&file=index.xml&xsl=article.xsl&). Sorry.

I wish that this wasn't the truth. It would be nice if you could achieve grandmaster status by learning only 101 simple [tweet](http://larryclarkin.com/2008/01/30/Twictionary.aspx)-sized messages in a month, a year, or even 5 years. But it's just not true.

There is some mixed hope however. One benefit from improving is that it becomes clearer where to find better information. That is, more signal in a noisy world. You get more of a "gut feel" of the feeds that should make the [top tier in your reader](http://www.moserware.com/2007/12/tip-organize-rss-feeds-by-tag-tiers.html) and more importantly, which ones shouldn't.

The downside, however, is that even if you only read the "good stuff," it will not be easy. If it's easy, you're not pushing hard enough.

Right now, I know I'm fairly weak on designing great classes that are easily testable. Through researching, I've found that [Rebecca Wirfs-Brock](http://www.wirfs-brock.com/rebeccasblog.html) has done some [great](http://www.amazon.com/Designing-Object-Oriented-Software-Rebecca-Wirfs-Brock/dp/0136298257) [work](http://www.amazon.com/Object-Design-Responsibilities-Collaborations-Addison-Wesley/dp/0201379430) in this area with her idea of "[responsibility driven design](http://www.wirfs-brock.com/PDFs/A%20Brief%20Tour%20of%20RDD%20in%202004.pdf)." But sometimes it's hard to understand what she has written. She tends to write in more [highbrow](http://en.wikipedia.org/wiki/Highbrow) places like [IEEE Software](http://www.computer.org/portal/site/software/) that are reasonably good sources of software design information. Unfortunately, these types of peer-reviewed journals are almost treated as if they have "[cooties](http://en.wikipedia.org/wiki/Cooties)" by most of the blogging world, so it's harder to find posts on the ideas they contain.

Last month, with the generous support of [my employer](http://www.inin.com/), I joined the [ACM](http://www.acm.org/) and subscribed to their fantastic [Digital Library](http://portal.acm.org/dl.cfm). One thing I like about the library and academic papers is that they force me to get out of my comfort zone. Almost none of the articles I've been reading have covered code in C# or even .net at all (even though I really like it and think it's a good platform). But this is [a good thing](http://www.paulgraham.com/avg.html); it's not about being an expert in other languages and platforms, just rather knowing that they exist and what they do well.

## A Sustainable Road to Grandmaster Status

Is there a path towards grandmaster status that still allows for a social life and avoids <a href="http://en.wikipedia.org/wiki/Death_march_(software_development)">80+ hour work weeks</a>? Is there a path that lets you invest the considerable time and energy into your kids and treat them as the [gifts](http://www.biblegateway.com/passage/?search=psalm%20127:3;&version=47;) that they are? Is there a road that lets you stop and smell the roses?

It *is* possible, but you need realistic expectations. Stay focused, but realize that it might take 25 - 30 years, especially if, like me, you haven't been *deliberate* in training. Anything worth doing takes [practice and persistence](http://video.google.com/videoplay?docid=362421849901825950). As [Fred Brooks observed](http://www.amazon.com/Mythical-Man-Month-Software-Engineering-Anniversary/dp/0201835959 "See the opening of chapter 2 where he covers the infamous ") on a New Orleans restaurant menu:

> Good cooking takes time. If you are made to wait, it is to serve you better, and to please you.

Come to grips with the fact that even a [great book](http://stevemcconnell.com/cc.htm) might only yield 6 - 7 good, lasting chunks. Make use of the great *human* resources around you, especially if they have similar focus. If you hear that they read a good book, ask them what [surprised them](http://www.paulgraham.com/essay.html) the most compared to what they expected the book to cover. Odds are there are only a few chunks. The question evokes more efficient learning. Keep reading yourself and share with others that care.

Look for passion, especially in others that aren't like you at all. Do you know someone that always raves about <a href="http://en.wikipedia.org/wiki/Python_(programming_language)">Python</a>, <a href="http://en.wikipedia.org/wiki/Ruby_(programming_language)">Ruby</a>, or <a href="http://en.wikipedia.org/wiki/Scala_(programming_language)">Scala</a>? Ask them about what's painful to do in those languages and seek hard to understand those points. You'll probably learn something interesting. For the same reason, find problems with your favorite language and be able to articulate them in a professional manner. You'll probably be a better developer as a result.

Don't be alarmed if junior programmers don't understand what you mean when you use your "code defensively" chunk on them. If it took you 15 years worth of war stories in the trenches to get it, it'll probably take the best ones at least 5, even with your guidance. Help them anyway. By doing so, you'll begin to repay the huge debt you took out when learning the profession.

When you see a great design or piece of code created by someone else, ask them how long it took to produce. You might be suprised that it took several rewrites and refactorizations to get there. This gives you hope that things are possible. When people, especially junior people, ask you how long it you to create something, don't try to hide the fact if it took several iterations and false starts to get there. This will also help you solidify the chunks that got you there and perhaps help you store a more efficient path for the future.

Branch out into unfamiliar territory that looks interesting on a regular basis, even if it's just for 15 minutes a day. If your employer [encourages this](http://en.wikipedia.org/wiki/Google#.22Twenty_percent.22_time), you'll probably grow faster.

When faced with a decision of choosing what to invest time into learning, don't overlook practicing the ones that "[you] hate, the kind that [lead] to failure and hair-pulling and fist-pounding." You're likely to improve faster that way.

Once you made the decision, always make your studies "deliberate" and "effortful." [Philip Ross expands on this](http://www.sciam.com/article.cfm?chanID=sa006&colID=1&articleID=00010347-101C-14C1-8F9E83414B7F4945):

> Ericsson argues that what matters is not experience per se but "effortful study," which entails continually tackling challenges that lie just beyond one's competence. That is why it is possible for enthusiasts to spend tens of thousands of hours playing chess or golf or a musical instrument without ever advancing beyond the amateur level and why a properly trained student can overtake them in a relatively short time. It is interesting to note that time spent playing chess, even in tournaments, appears to contribute less than such study to a player's progress; the main training value of such games is to point up weaknesses for future study. 

> Even the novice engages in effortful study at first, which is why beginners so often improve rapidly in playing golf, say, or in driving a car. But having reached an acceptable performance--for instance, keeping up with one's golf buddies or passing a driver's exam--most people relax. Their performance then becomes automatic and therefore impervious to further improvement. In contrast, experts-in-training keep the lid of their mind's box open all the time, so that they can inspect, criticize and augment its contents and thereby approach the standard set by leaders in their fields.

[Good software takes at least 10 years to develop](http://www.joelonsoftware.com/articles/fog0000000017.html) because it takes programmers [at least 10 years to develop good proficiency in programming](http://norvig.com/21-days.html) and the problem domain.

Don't forget that all of this presupposes that you enjoy software development. I'm privileged to have a "hobby" that also pays the bills. But, if you don't honestly enjoy the field, you probably won't care about wanting to go down this road in the first place. As [Daniel Goleman alludes to](http://query.nytimes.com/gst/fullpage.html?res=9D00E1DC1F3DF932A25753C1A962958260&sec=&pagewanted=all), a key driver that lends itself towards efficient chunking is passion:

> "The most contentious claim made by Dr. Ericsson is that practice alone, not natural talent, makes for a record-breaking performance. 'Innate capacities have very little to do with becoming a champion,' said his colleague, Dr. Charness. 'What's key is *motivation and temperament*, not a skill specific to performance. *It's unlikely you can get just any child to apply themselves this rigorously for so long*.'" (Emphasis added)

It will take lots of time, but don't forget to have fun and take plenty of breaks. Your body needs it:

> "When we train Olympic weight lifters, we find we often have to throttle back the total time they work out," said Dr. Mahoney. "Otherwise you find a tremendous drop in mood, and a jump in irritability, fatigue and apathy."

All of the above was to just convey that "Software Grandmaster" status can only occur after at least 10 years of very deliberate focus on areas that stretch you. Maybe this post might have qualified as a 1/50,000th to 1/100,000 of the way towards getting you there.

Then again... maybe not. It's your move.

Let me know through comments.