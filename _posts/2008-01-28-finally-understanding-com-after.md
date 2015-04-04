---
layout: post
title: "Finally Understanding COM After Changing a Light Bulb"
date: 2008-01-28 21:30:00
updated: 2009-08-25 22:04:08
permalink: /2008/01/finally-understanding-com-after.html
---
<img style="MARGIN: 0px 0px 20px 20px" align="right" src="/assets/finally-understanding-com-after/LightbulbSocket_320.JPG"> Recently I discovered that my passenger low-beam headlight burnt out. More accurately, the nice police officer who pulled me over and *only gave me a verbal warning* let me know it had burnt out. With this new knowledge, I went to the local auto parts store to find a new one.

I uninstalled the broken one and brought it in with me. On the bottom of it, there was a "9006" identifier. The lady at the store helped me find another "9006" low beam headlight and it took about a minute to install.

It sort of reminds me of how relatively simple COM is at its core.

For the past *decade*, the sum of all of my knowledge about COM was approximately:

-   It stood for Component Object Model 
-   It looked painful: avoid it like you'd avoid eating at a restaurant publicly condemned by the Board of Health. 
-   Somehow it involved interfaces. 
-   You had to manage your own memory. 
-   Windows uses it everywhere... somehow. 
-   It [was replaced by .NET](http://www.microsoft.com/com/default.mspx), so forget about it. 
-   I could use COM classes (like the [one for IE](http://msdn2.microsoft.com/en-us/library/aa741313.aspx)) in VB and .NET, but I had no idea how it worked under the covers. 
-   Nothing on earth was worse than "DCOM," or so I'd been told.

You probably knew more than that, but that's probably what I would have squeaked out if push came to shove. In my life, I never really had to really understand COM at all, so I didn't even bother.

Recently, I had to break down and actually learn enough about it to get some things done. I learned that it's really not that bad. Please consider this as the *[absolute minimum](http://www.joelonsoftware.com/articles/Unicode.html)* that a Windows programmer should know about COM. I wish I had, it would have made things faster to learn.

The first thing to learn is that there are three major figures in COM:

### Client

![](/assets/finally-understanding-com-after/COMClient.png)

A client is somebody that wants to get a job done. Maybe he's trying to get a light bulb for his car. Or, perhaps it's someone who's trying to play some music. Another possibility it's someone that wants to display a web page or talk to Outlook. It doesn't really matter, it's someone that wants to do something.

### Server

![](/assets/finally-understanding-com-after/COMServer.png)

A server is something that wants to do some tasks for you. He's the guy that the client is pushing around. He only does a few tasks that are on a menu that the client knows about.

### (Bee) "Hive" Keeper (a.k.a. "Registry")

![](/assets/finally-understanding-com-after/COMHive.png)

The bee "hive" is buzzing with activity. Imagine a bee keeper that stores all of his notes on the individual "cells" of a honey comb. It's sort of like a big telephone directory, but one that was designed by someone who [hates bees](http://blogs.msdn.com/oldnewthing/archive/2003/08/08/54618.aspx).

Now that we know the key players, let's get back to our light bulb. Imagine that all you had in the world were the three major players above. What would have need to have happened?

Well, the server in this case would be a light bulb. Wanting to copy Apple's naming convention, let's call him iLight, or more boringly: ILight. Now ILight had to advertise himself to the world. The menu of things that the client can request him to do include "Turn On" and "Turn Off" and maybe "CalculateWattage." He has a boring part number just like my real light did (e.g. 9006). Let's say that he walked over to the hive and wrote down in the directory that "ILight is part #9006" and also wrote down exactly where in the store to find him. The only real requirement is that this must happen before any clients can use him.

The client is just like me and knows he needs something that can "Turn On," "Turn Off," and "CalculateWattage." He looks in his car manual and finds out he needs an ILight. He goes to Hive and finds that "ILight" is part number "9006." Next, he goes to the "cell" where information on part "9006" is stored and finds exactly where to find it. He picks up the ILight and lives happily ever after.

See? Not too hard right? At a high level, it's pretty simple. For fun, let's dive deeper into the reality that is COM.

![](/assets/finally-understanding-com-after/NewLightBulbATLProject.png)

"ILight" would more than likely have started his life in Visual Studio as an ATL (ActiveX Template Library) project. ATL is just a simple way of dealing with the gooey parts of COM that don't really matter that much. ATL projects are written in C++, so they're sure to bring fond memories of your college days back.

In the project, we'd create a new class of type "ATL Simple Object" (see, it's *simple* :))

![](/assets/finally-understanding-com-after/AddClassSimpleObject.png)

And give it a name of "Light" and have the wizard automatically fill in the details:

![](/assets/finally-understanding-com-after/ATLSimpleObjectWizard.png)

It doesn't matter if we get scared after clicking next, we just need to hit finish and trust the defaults (remember, this is the absolute *minimum* you should know):

![](/assets/finally-understanding-com-after/ATLSimpleObjectComplexOptions.png)

Next, go to the class view window on the right hand side of their screen and right click on the "ILight" interface and add a few methods:

![](/assets/finally-understanding-com-after/AddMethod.png)

The first method being "TurnOn" (and similarly turn-off) that has no arguments:

![](/assets/finally-understanding-com-after/AddTurnOn.png)

To make it interesting, let's say there was one more method called "CalculateWattage" that takes two parameters (volts and amps) and returns the wattage:

![](/assets/finally-understanding-com-after/AddCalculateWattage.png)

Now, one would go to the Light.cpp and fill in the definition of these functions. In this example, we'll just show a message box for the turn on/turn off commands. Note that for the "CalculateWattage" function, we return the result via a parameter pointer. This is important since the return value for COM methods is almost always the status of whether it succeed or not. Successful responses always start with "S_" and errors always start with "E_". The COM-ese for this is the "[HRESULT](http://en.wikipedia.org/wiki/HRESULT)" that you can think of as "here's the result of the function call."

![](/assets/finally-understanding-com-after/LightCppImplementation.png)

If you actually spent your time in C++ as a client, you'd have to make calls like this:

![](/assets/finally-understanding-com-after/SampleCppCallToCOM.png)

You can't simply check a value to be equal to something since *any* result that starts with "E_" is a failure (popular ones include E_FAIL and E_NOINTERFACE). The "FAILED" macro just checks to see if the most significant bit is set.

Now, when going to build the project on Vista, a curious error is reported:

![](/assets/finally-understanding-com-after/RegNeedElevation.png)

*What happened?* Well, answering that will take us back to the hive.

When we created the ILight interface and its concrete implementation, Visual Studio automatically created a "part number" for us that is a really huge number called a Globally Unique Identifier ([GUID](http://en.wikipedia.org/wiki/Globally_Unique_Identifier)). The number is so big that it makes us yearn for the days of simple part numbers like 9006. In order for clients to be able to find our component, they need to look up our part number or our name in a special area in the registry/hive. Specifically, the servers need to put their details under the hive key (HKEY) that is the root of all classes/servers. This is conveniently called "HKEY_CLASSES_ROOT":

![](/assets/finally-understanding-com-after/HkeyClassesRoot.png)

But we don't want just *anyone* being able to write there right? If any ol' server could just write into that area, they could replace a good implementation of ILight with one that say, recorded all your keystrokes and sent them to some COM-enlightened hacker several timezones away. This is just one of the reasons why setup programs require a User Account Control ([UAC](http://en.wikipedia.org/wiki/User_Account_Control)) elevation before they will start. Microsoft is guessing that setup will probably want to register some COM server or write to a directory that the standard user doesn't have permission to write to (e.g. "C:\Program Files"), and gets it out of the way early.

When you go to build the project, Visual Studio will create a helper batch file for you in your project's debug directory and run it. If you use a tool like [Process Monitor](http://technet.microsoft.com/en-us/sysinternals/bb896645.aspx), you can see all of this happening:

![](/assets/finally-understanding-com-after/VSLaunchBatchFile.png)

If you're really quick, you'll be able to copy the batch file before Visual Studio deletes it after it gets an error. Here's what the batch file looks like:

![](/assets/finally-understanding-com-after/HelperBatchContents.png)

All that the batch file does is call out to "[regsvr32](http://technet.microsoft.com/en-us/library/bb490985.aspx)," which clearly stands for "register 32 bit COM server." I say that a little tounge-in-cheek because I had seen the "regsvr32" name hundreds of times before and never really understood what a server meant. "What's a server?!" However, in hindsight, it's quite simple. It's just a COM class that can do work.

When regsvr32 goes to write into the HKEY_CLASSES_ROOT area (abbreviated HKCR), it gets denied:

![](/assets/finally-understanding-com-after/ComRegisterDenied.png)

Note that the text after the "VCReportError" label in the batch file is exactly what was reported to us in Visual Studio's error window.

What are we to do now? Well, the simple answer is to run Visual Studio again, but this time with administrator privileges and try it again:

![](/assets/finally-understanding-com-after/VS2005RunAsAdmin.png)

This time, DevEnv.exe has administrator credentials and this causes the batch file to run under administrator credentials which, you guessed it, causes regsvr32.exe to run with administrator credentials and therefore allows us to write into HKEY_CLASSES_ROOT.

Now, our component is registered. To learn exactly what this means, we need to use another tool called "OLE-COM Object Viewer" (oleview.exe) that's part of the [Windows SDK](http://blogs.msdn.com/windowssdk/). OleView simply lets you see all of the components/servers that are registered on your machine. It's like browsing an auto parts store. If we search for our "Light" component, we'll see a screen like this:

![](/assets/finally-understanding-com-after/OleViewOnLight.png)

Which is full of all sorts of great information about our Light pulled from many different areas of the hive. For example, it says that our light class implements the ILight interface that has the interface identifier of "BBABC3ED-E2B6-4023-AE58-1B04E80E0DAE" and the concrete class has a part number/class identifier of "98C0E3FF-264C-4919-8DE6-F4D87B83D779." Furthermore, the location in the "store" is on the file system at "C:\Users\Jeff.Moser\Documents\Visual Studio 2005\Projects\LightBulb\LightBulb\Debug\LightBulb.dll". The class has a version specific name of "Acme.Light.1", and it also goes by the version non-specific name of "Acme.Light".

Impressive! It's a little more complicated than the auto parts store, but not *that* much. The hive is buzzing with information about how to find our component and what it provides.

Now, let's jump over to client land. The client can be *anything* that supports COM. For example, VBA in Excel. We can either add a reference to it by clicking Tools*References:

![](/assets/finally-understanding-com-after/AddRefLightBulb.png)

and then write some VBA code to use it:

![](/assets/finally-understanding-com-after/StrongTypeVBA.png)

Note that we can do the exact same code in C# in a similar way:

![](/assets/finally-understanding-com-after/CSharpUsingLightBulb.png) Neat huh? Note that we didn't have to check for HRESULTs like we would have done in C++. The reason is that under the covers, the VBA runtime (and C# .NET [Runtime Callable Wrapper](http://msdn2.microsoft.com/en-us/library/8bwh56xe.aspx) and CLR) do that for you. If the function returns an error, an exception is generated so that you can't ignore it.

Another nice feature is that we can take advantage of the fact that the hive can retrieve information about our class just by its string name (ProgID). The following code has the same result for the CalculateWattage call:

![](/assets/finally-understanding-com-after/LightCreateObject.png)

We can do the same thing in C#, but the syntax will be little messier until [C# 4.0's support for dynamic lookup](http://blogs.msdn.com/charlie/archive/2008/01/25/future-focus.aspx) is available:

![](/assets/finally-understanding-com-after/CSharpCreateObject.png)

It's the exact same idea, but we get less language support.

So *that* is what COM is all about. Well, that's what I would say is an absolute minimum to get by without assuming things are just magic. I left out a few details that aren't 100% necessary to know:

-   No sane person would write a COM implementation without using a framework like ATL to handle all the "goo." 
-   A middleman like COM (or [CORBA](http://en.wikipedia.org/wiki/CORBA) for that matter) must exist because in the wild, you get inconsistencies that prevent you from using raw binaries directly in your code. For example, different C++ compilers [mangle function names](http://en.wikipedia.org/wiki/Name_mangling) differently. If you try to allow binary interoperability, you'll inevitably recreate something like COM. 
-   COM actually creates a factory class from your DLL that, in turn, creates your class. 
-   Your don't have to implement your class as a DLL (in process). You can have it be an EXE (out of process) that is running. In this case, the EXE runs and registers itself with the OS and says that it's running and ready for work. If it isn't already running, the OS will start it. 
-   All classes must implement the [IUnknown](http://en.wikipedia.org/wiki/IUnknown) interface. This interface lets you "cast" your pointer to another interface (via the [QueryInterface](http://msdn2.microsoft.com/en-us/library/ms682521%28VS.85%29.aspx) method) and it also keeps track of memory. 
-   The pointer that you get back from COM is actually an entry into your class's [v-table](http://en.wikipedia.org/wiki/Virtual_table) for the requested interface. This is what ultimately drives the requirement that interfaces [must never ever change](http://blogs.msdn.com/oldnewthing/archive/2005/11/01/487658.aspx) once published in the wild. Note that all "casts" of a pointer must go through COM. This is because it's important that you do essentially [static_cast](http://msdn2.microsoft.com/en-us/library/c36yw7x9%28VS.80%29.aspx) instead of a [reinterpret_cast](http://msdn2.microsoft.com/en-us/library/e0w9f63b%28VS.80%29.aspx). The latter would give you weird results if you tried it on a pointer that didn't have the method you wanted. 
-   Since an interface cannot change once it is published, and because a v-table is used, the common pattern is to use an increasing number after the base name for each successive revision and have the new interface inherit from the old one. For example, IWebBrowser2 inherits from IWebBrowser and adds methods to the end of it. 
-   COM doesn't have a [garbage collector](http://en.wikipedia.org/wiki/Garbage_collection_%28computer_science%29) like .NET and Java does. For this reason, you have to explicitly keep track of how many instances of your COM class there are. When the number drops to 0, it can be removed from memory. IUnknown handles this. ATL gives you a good implementation of this automatically. 
-   By default, COM uses a message queue for coordination. This introduces several different "[apartment threading models](http://msdn2.microsoft.com/en-us/library/ms693344%28VS.85%29.aspx)." These strictly exist to make sure you're careful with multithreading and access to shared state. You'll eventually need to know more about these. The apartments get created when you call COM/COmponent Intialize ([CoInitialize](http://msdn2.microsoft.com/en-us/library/ms678543%28VS.85%29.aspx)) or the simpler, [CoCreateInstance](http://msdn2.microsoft.com/en-us/library/ms686615.aspx). 
-   When a .NET class calls a COM class, a Runtime Callable Wrapper (RCW) is created to handle all the IUnknown goo. 
-   When a COM client needs to call .NET code, an aptly named "[COM Callable Wrapper](http://msdn2.microsoft.com/en-us/library/f07c8z1c.aspx)" (CCW) is created and used. The neat trick is that this is essentially a reference to the .NET core runtime with your assembly passed in as an argument. This is how the .NET side of the house is bootstrapped. 
-   [IDispatch](http://en.wikipedia.org/wiki/IDispatch) is an interface that essentially lets you call functions by name and gives you a poor-man's version of .NET's reflection. This is the magic that allows scripting languages to work so well. Instead of binding to a specific function at compile time and getting compiler support, you can do runtime lookups. It essentially allows for the differences between my first and second example. Note that my Light class implemented both ILight *and*IDispatch. Again, ATL handled all the magic here. 
-   As you dig deeper into COM, you'll note that the Interface Description Language ([IDL](http://msdn2.microsoft.com/en-us/library/aa367091%28VS.85%29.aspx)) plays an important role in making sure all languages of COM understand the details about your component properly. Basically, languages agree on how they'll handle things defined in IDL. Once again, ATL hides most of this 
-   Note that to use a COM class, we had to make an entry into the registry. This entry requires elevated permissions like I mentioned earlier. This is a bit of an overkill if your application is the only one that uses it. I think that Microsoft realized this as they were making the big UAC push in the development of Vista. This led to an update in XP SP1 called "[Registration-Free COM](http://msdn.microsoft.com/msdnmag/issues/05/04/RegFreeCOM/)" which allows you to create a file that is named the same as your .dll/.exe except that it ends in the ".manifest" extension. It's an XML file that has the same type of information that the hive/registry has. However, it doesn't require you to have the elevation to get an entry into HKEY_CLASSES_ROOT. It's useful for using in low permission environments. 
-   There are a lot of good articles on COM, they're just hard to find. I've [tagged a few](http://del.icio.us/moserware/COM) that were helpful to me on del.icio.us. Please let me know if you think I missed a good one and I'll check it out.

COM is a necessary layer due to the binary incompatibility problems. Since we now have .NET, when you look back at COM, it's sort of like your grandparents telling you how they washed clothes without electricity. It was a bit more involved and tedious, but it got the job done. COM started in the early 90's, well before Java and the CLR with its unified type system. Since many of the core classes/servers of Windows and Microsoft Office use COM, it will be around for a long, long, *long* time.

It's good that I finally understand it enough to make use of it effectively!

How did *you* learn about COM?

**UPDATE:**I wrote about "[Using Obscure Windows COM APIs in .NET](http://www.moserware.com/2009/04/using-obscure-windows-com-apis-in-net.html)."