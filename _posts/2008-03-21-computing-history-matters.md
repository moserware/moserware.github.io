---
layout: post
title: "Computing History Matters"
date: 2008-03-21 07:49:00
updated: 2008-12-11 00:10:01
permalink: /2008/03/computing-history-matters.html
---
In a few milliseconds my brain made the connection and I had one of those "so *that* is where it came from!" moments.

When I was in [Silicon Valley](http://en.wikipedia.org/wiki/Silicon_Valley) last week, I had the privilege of taking a tour of the [Computer History Museum](http://www.computerhistory.org/). One of the stops was in front of these hanging grids:

![](/assets/computing-history-matters/corememoryhanging.JPG)

I had no idea what they were. My friendly tour guide, Fred Ware, told me that I was looking at "[core memory](http://en.wikipedia.org/wiki/Magnetic_core_memory)." It was an early form of memory technology that used small holes, or *cores*, through which wires were inserted. This setup allowed the machine to control the [polarity](http://en.wikipedia.org/wiki/Polarity_%28physics%29) of the [magnetic field](http://en.wikipedia.org/wiki/Magnetic_field) created and thereby store data inside of them.

When I first started programming on a [Unix](http://en.wikipedia.org/wiki/Unix) machine in college, I would occasionally do something stupid like try to peek at the contents at memory [address zero](http://en.wikipedia.org/wiki/Null_pointer#The_null_pointer) which would do bad things, cause a crash, and give me a "[core dump](http://en.wikipedia.org/wiki/Core_dump)." I had always assumed that the "core" referred to in the error message was an adjective for "main," but when I saw real "core memory," I realized that I had misunderstood the term for years.

Our industry is full of terms that seem awkward unless you know their history. Even basic things like the "[print](http://en.wikipedia.org/wiki/Printf)" method in almost all languages doesn't make much sense unless you see that it goes back to the days when you connected to a computer via a [TeleTYpe](http://en.wikipedia.org/wiki/Teletype) (TTY) machine that *print*ed its result on rolled paper.

This isn't unique to computing. Human languages have quite a bit of [history in their words](http://en.wikipedia.org/wiki/Etymology). For example, the word "[salary](http://en.wikipedia.org/wiki/Salary)" comes from the bygone days when you were paid for your labor *in salt*. The difference with computing history is that most of it happened recently and most of the people that created it are still alive.

Great stories are just below the surface of things you use each day. While I knew that [Linux](http://en.wikipedia.org/wiki/Linux) is a [Unix-like](http://en.wikipedia.org/wiki/Unix-like) [operating system](http://en.wikipedia.org/wiki/Operating_system) that was [started by](http://groups.google.com/group/comp.os.minix/msg/b813d52cbc5a044b?dmode=source) [Linus Torvalds](http://en.wikipedia.org/wiki/Linus_Torvalds) when he was a student the [University of Helsinki](http://en.wikipedia.org/wiki/University_of_Helsinki), I didn't realize until last week the interesting story of "Unix" itself. The name probably came about as a result of a silly pun. [It was a "castrated" version of MULTICS](http://books.google.com/books?id=qE0U0_Acf24C&pg=PA496&lpg=PA496&dq=multics+unics+castrated&source=web&ots=A2lJahkGZZ&sig=0m7RxxUh4se4KDEQfvMiGhoO7Qc&hl=en). The [MULTICS](http://en.wikipedia.org/wiki/Multics) operating system was developed in the mid 1960's to be a better [time-sharing](http://en.wikipedia.org/wiki/Time-sharing) operating system for the expensive computer time of the day. Perhaps frustrated with the complexity of MUTLICS, [Ken Thompson](http://en.wikipedia.org/wiki/Ken_Thompson) wrote a rough "simplified" version of it [in a month](http://books.google.com/books?id=qE0U0_Acf24C&pg=PA496&lpg=PA496&dq=multics+unics+castrated&source=web&ots=A2lJahkGZZ&sig=0m7RxxUh4se4KDEQfvMiGhoO7Qc&hl=en). Thus, the story goes, it was "UNIplexed" and simpler where MULTICS was "MULTiplexed" and complicated.

![](/assets/computing-history-matters/jeffunixpdp11.JPG)

Unix's history gives color to the people that created it. I'm certainly no Ken, but I can relate to the feeling that some code seems overly complex and feel the itch to rewrite it to something simpler. It's neat to see that his diversion worked out so well. It's also a testament to the people behind MULTICS that most of the central ideas in our "modern" operating systems trace their origin to it.

Programming languages tend to have a story as well. Usually the most interesting is the philosophy that drove their creation. A good representative sample is the philosophical gap between [Simula](http://en.wikipedia.org/wiki/Simula) and [C++](http://en.wikipedia.org/wiki/C%2B%2B).

Simula is regarded as the first [object-oriented](http://en.wikipedia.org/wiki/Object-oriented_%28programming%29) programming language. It too was developed in the golden era of Computer Science in the 1960's. As [stated by its creators](http://doi.acm.org/10.1145/800025.1198392 "see pages 445-447"):

> "From the very outset SIMULA was regarded as a system description language"

This naturally led to the bold design objective #6:

> "It should be problem-oriented and not computer-oriented, even if this implies an appreciable increase in the amount of work which has to be done by the computer."

It was so bold, that they had to tone it down a bit. They still had 1960's hardware after all:

> "Another reason for the [de-emphasizing the above goal] was that we realized that the success of SIMULA would, regardless of our insistence on the importance of problem orientation, to a large to a large extent depend upon its compile and run time efficiency as a programming language."

Regardless, it's telling of its philosophy. As [David West writes](http://books.google.com/books?ei=4XzgR6jaK4SkiQG9iJgn&id=-eJQAAAAMAAJ&dq=object+thinking&q=SIMULA+team+point+to+an+important&pgis=1):

> "Both [Parnas](http://en.wikipedia.org/wiki/David_Parnas) and the SIMULA team point to an important principle. Decomposition into subunits is necessary before we can understand, model, and build software components. If that decomposition is based on a 'natural' partitioning of the domain, the resultant models and software components will be significantly simpler to implement and will, almost as a side effect, promote other objectives such as operational efficiency and communication elegance. If instead, decomposition is based on 'artificial,' or computer-derived, abstractions such as memory structures, operations, or functions (as a package of operations), the opposite results will accrue."

As David continues, the philosophy of Simula was:

> "... to make it easier to describe natural systems and simulate them in software, even if that meant the computer had to do more work."

[Bjarne Stroustrup](http://en.wikipedia.org/wiki/Bjarne_Stroustrup) took a different approach with C++:

> "SIMULA's class-based type system was a huge plus, but its run-time performance was hopeless: 

>The poor runtime characteristics were a function of the language and its implementation. The overhead problems were fundamental to SIMULA and could not be remedied. The cost arose from several language features and their interactions: **run-time type checking, guaranteed initialization of variables, concurrency support, and garbage collection**..." (Emphasis added) 

>"C with Classes [precursor to C++] was explicitly designed to allow better organization of programs; 'computation' was considered a problem solved by C. I was very concerned that **improved program structure was not achieved at the expense of run-time overhead compared to C**." (Emphasis added)

This simple historical account alone can probably guide you to answers to things that seem odd or annoying about C++. It also reveals a larger truth. Usually if someone way smarter than me, like Bjarne, creates or does something that I think is weird, there's probably an [interesting historical reason](http://blogs.msdn.com/oldnewthing/archive/tags/History/default.aspx) behind it. In C++, the driving force was almost always performance. I find it amusing that a lot of the "new" ideas in languages and runtimes are just bringing back things from Simula that C++ took out.

Practicalities like performance often hinder the adoption of otherwise superior technology. [Betamax](http://en.wikipedia.org/wiki/Betamax) lost because it only held an hour of video compared to [VHS](http://en.wikipedia.org/wiki/VHS)'s three. Not being able to store a full length movie is a real problem. The [QWERTY](http://en.wikipedia.org/wiki/QWERTY) keyboard layout was designed in the **1860'**s when it was important to separate common letter pairs like "th" in order to [prevent typebar jamming](http://home.earthlink.net/~dcrehr/whyqwert.html). When computer keyboards were designed, the designers simply copied the already popular QWERTY layout to ease adoption even though other, [potentially](http://www.utdallas.edu/~liebowit/keys1.html) [more efficient](http://en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard), layouts were available. Sometimes a "good enough" solution wins because the better approach isn't worth the transition cost.

Popular history often misleads people into thinking that things came easily to the innovators. The real stories offer hope because they demonstrate that you too can make history if you're willing to persevere.

[Google](http://www.google.com/ig?hl=en)'s founders [Larry Page](http://en.wikipedia.org/wiki/Larry_Page) and [Sergey Brin](http://en.wikipedia.org/wiki/Sergey_Brin) [were turned down](http://www.oreilly.com/catalog/9780596527051/ "see page 54") when they tried to sell their core [PageRank](http://en.wikipedia.org/wiki/PageRank) algorithm to [AltaVista](http://www.altavista.com/) and [Yahoo](http://www.yahoo.com/). One of my favorite stories is that almost no one believed [Bob Kahn](http://en.wikipedia.org/wiki/Robert_E._Kahn), the inventor of [TCP](http://en.wikipedia.org/wiki/Transmission_Control_Protocol), when he advocated that [congestion control](http://en.wikipedia.org/wiki/Congestion_control) would be important on a [large network](http://en.wikipedia.org/wiki/ARPANET). It wasn't until the first 12 packets were sent out and [congestion actually occurred](http://video.google.com/videoplay?docid=-4669674613016912378 "Bob talks about this during this interview") did people finally agree that it could be a problem.

Probably the biggest misconception is how [Isaac Newton](http://en.wikipedia.org/wiki/Isaac_Newton) came to explain [gravity](http://en.wikipedia.org/wiki/Gravity). [Scott Berkun](http://www.scottberkun.com/) [writes](http://www.oreilly.com/catalog/9780596527051/):

> "It's disputed whether Newton ever observed an apple fall. He certainly was never struck by one, unless there's secret evidence of fraternity food fights while he was studying in Cambridge. Even if the apple incident took place, the telling of the story discounts Newton's **20 years of work** to explain gravity, the feat that earned him the attention of the world" (Emphasis added)

[Tim Berners-Lee](http://en.wikipedia.org/wiki/Tim_Berners-Lee), the primary man behind the [web](http://en.wikipedia.org/wiki/World_Wide_Web), [tells a similar story](http://www.w3.org/People/Berners-Lee/Weaving/):

> "Journalists have always asked me what the crucial idea was or what the singular event was that allowed the Web to exist one day when it hadn't before. They are frustrated when I tell them there was no <a href="http://en.wikipedia.org/wiki/Eureka_(word)">Eureka</a> moment. It was not like the legendary apple falling on Newton's head to demonstrate the concept of gravity... it was a process of [accretion](http://en.wiktionary.org/wiki/accretion) (growth by gradual addition)."

What's the history lesson? Don't worry if you never have an apple falling on your head moment. Newton didn't have one either. Things take a lot of hard work and perseverance. True stories of innovator's persistence [go on](http://www.wd40.com/AboutUs/our_history.html) [and on](http://en.wikipedia.org/wiki/Arsphenamine). While you're slogging away, don't worry about mistakes too much:

> "Anyone who was never made a mistake has never tried anything new." - [Einstein](http://www.quoteworld.org/quotes/4138)

Simply [learn from them](http://www.quotationspage.com/quote/30392.html) and move on.

Although doing something [insanely great](http://www.amazon.com/Insanely-Great-Macintosh-Computer-Everything/dp/0140291776) might take a long time, it demonstrates how important people are in our industry. People are the most important part of any industry because it is through them and their stories that history is created. People are especially important in computing. Unfortunately, some of their most interesting stories are practically unknown by most:

-   [Alan Turing](http://en.wikipedia.org/wiki/Alan_Turing) wrote [the paper](http://www.abelard.org/turpap2/tp2-ie.asp) that effectively started computing as we know it. 
-   [William Shockley](http://en.wikipedia.org/wiki/William_Shockley) practically put the "silicon" in "Silicon Valley," 
-   Our modern Internet exists in large part because of the [fascinating story](http://www.amazon.com/Dream-Machine-Licklider-Revolution-Computing/dp/014200135X) of [J.C.R. Licklider](http://en.wikipedia.org/wiki/J._C._R._Licklider) who used [ARPA](http://en.wikipedia.org/wiki/Defense_Advanced_Research_Projects_Agency) funding to work on his dream that everyone should have a personal computer connected to an "[Intergalactic Computer Network](http://en.wikipedia.org/wiki/Intergalactic_Computer_Network)." 
-   [Bob Taylor](http://en.wikipedia.org/wiki/Robert_Taylor_%28computer_scientist%29), the man that led the wildly successful Xerox Palo Alto Research Center ([PARC](http://en.wikipedia.org/wiki/Xerox_PARC)) inspired creativity in the great people that worked with him by creating environment that encouraged exploration and laughter. 
-   [Dave Cutler](http://en.wikipedia.org/wiki/Dave_Cutler_%28software_engineer%29) was in large part the reason why we have the much more reliable NT kernel running on our computers and aren't stuck with "toy" Windows 9x one.

Their stories are full of little gems. You sometimes get to see what drove their curiosity. [Bob Barton](http://en.wikipedia.org/wiki/Robert_(Bob)_Barton), arguably one of the greatest hardware designers ever, made the comment "I often thank IBM because they gave me so much motivation to do better." I'm sure that Google's founders could say the same thing about AltaVista of the 1990's.

I think that one of the reasons for the [plummeting enrollment in Computer Science majors](http://www.npr.org/templates/story/story.php?storyId=88154024) is that there is a lack of understand of people and their stories in our field. This leads to the perception that a career in computing will result in a "social death." I might be biased, but I think we have great stories. If you haven't visited it yet, check out the videos on the [Computer History Museum section on YouTube](http://www.youtube.com/computerhistory). They're quite interesting.

I'll close with one lesson from computing history: don't be afraid to dream big. When [Vint Cerf](http://en.wikipedia.org/wiki/Vinton_Cerf) had to [put an upper limit](http://ondemand.video.t-online.hu/mte/070402_vint_eloadas_angol_szeles.wmv "Vint mentions this during this talk. Don't worry, only the introduction is in Hungarian.") in 1977 on the number of addresses for what would become the Internet, he probably thought that 4 *billion* addresses would never be used, but that's the "[address exhaustion](http://en.wikipedia.org/wiki/IPv4_address_exhaustion)" problem that we're facing now. Be careful when creating something, it just might exceed your wildest dreams.

Why do we as an industry largely ignore our history and rarely mine its rich stories? Do we think we're moving too fast for it to be relevant? I think that it's important to understand our history exactly because we're moving so fast. It seems that learning principles that are timeless or much longer lived is more valuable than keeping up with the deep intricacies of the latest technology of the day that won't matter in a year or two.

What's your favorite piece of computing history? Who are the people that you remember? What are their stories?

**P.S.** Special thanks to [Alan Kay](http://en.wikipedia.org/wiki/Alan_Kay) for sharing some of his stories with me last week.