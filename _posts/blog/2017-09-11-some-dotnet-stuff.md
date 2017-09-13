---
layout: post
title:  "Some .NET Stuff"
date:   2017-09-11 19:06:31 -0400
categories: blog dotnet
---

Some cool tex

{% highlight C# %}
public class Program
{
    public static void Main(string[] args)
    {
        var assembly = Assembly.GetExecutingAssembly().Location;
        var pkgEnv = Environment.GetEnvironmentVariable("NET_PKG");

        if (string.IsNullOrEmpty(pkgEnv))
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
