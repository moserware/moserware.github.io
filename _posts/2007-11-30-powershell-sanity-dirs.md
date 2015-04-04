---
layout: post
title: "Powershell Sanity: dir/s"
date: 2007-11-30 09:34:00
updated: 2014-04-11 09:50:26
permalink: /2007/11/powershell-sanity-dirs.html
---
After trying to type it over 10 times, I finally added it to my profile:

{% highlight powershell %}
function Find-Files-Recursive($includes) { 
    Get-ChildItem -r -i $includes | % {$_.FullName} 
}
Set-Alias dir/s Find-Files-Recursive
{% endhighlight %}