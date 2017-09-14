---
layout: post
title: "Fix ASP.NET Assets in Appimages"
date: 2017-09-14 13:52:48 -0400
categories: blog linux
---

Bundling your .NET Core applications into AppImages simplifies the distribution of your software on Linux. Ever since Microsoft released version 2.0 of .NET Core, this has become even easier with the introduction of the generic `linux-x64` [Runtime IDentifier](https://github.com/dotnet/docs/blob/master/docs/core/rid-catalog.md#linux-rids) (RID). This RID replaces the distro-specific RIDs (`ubuntu-16.04-x64`, `fedora.24-x64`, etc) of previous versions of .NET Core.

### Shameless Plug: netpkg-tool

If you wish to simplify/automate the process of [bundling .NET Core apps into AppImages](https://github.com/AppImage/AppImageKit/wiki/Bundling-.NET-Core-apps), you can use *netpkg-tool*! Just follow the simple instructions for [downloading netpkg-tool](https://github.com/phil-harmoniq/netpkg-tool#released-binary), and then package your application like so:

{% highlight bash %}
netpkg-tool ~/path/to/source ~/path/to/destination
{% endhighlight %}

### Preparing Project

When generating a new ASP.NET project, you are presented with the following `Program` class:

{% highlight C# linenos %}
public class Program
{
    public static void Main(string[] args)
    {
        BuildWebHost(args).Run();
    }

    public static IWebHost BuildWebHost(string[] args) =>
        WebHost.CreateDefaultBuilder(args)
            .UseStartup<Startup>()
            .Build();
}
{% endhighlight %}

By default, ASP.NET looks for `wwwroot` in the current working directory. This works well up until you try to run your webapp from a different working directory (aka inside an AppImage). A work-around would be to detect if the application is being run from an AppImage and set its content root accordingly. If you are using *netpkg-tool* to build your AppImage, an environment variable is provided for this purpose. Simply check for the existance of `$NET_PKG` and set the content root to the assembly's directory if it is detected:

{% highlight C# linenos %}
public class Program
{
    public static void Main(string[] args)
    {
        var assembly = Assembly.GetExecutingAssembly().Location;

        if (string.IsNullOrEmpty(Environment.GetEnvironmentVariable("NET_PKG")))
            BuildWebHost(args, Directory.GetCurrentDirectory()).Run();
        else
            BuildWebHost(args, Path.GetDirectoryName(assembly)).Run();
    }

    public static IWebHost BuildWebHost(string[] args, string root) =>
        WebHost.CreateDefaultBuilder(args)
            .UseContentRoot(root)
            .UseStartup<Startup>()
            .Build();
}
{% endhighlight %}