---
layout: post
title: "Devloping on Linux with VS Code"
date: 2017-09-14 13:12:31 -0400
categories: blog linux
---

[VS Code](https://code.visualstudio.com/) is a very capable and extensible editor text editor developed by Microsoft based off of Github's [Atom](https://atom.io/) editor. For the past year, it has been my editor of choice for nearly any project/language. The plugin ecosystem contains essential tools one would need for almost any type of development.

### Integrated Terminal

One of my favorite features of VS Code is its integrated terminal which can be opened with `` Ctrl+` ``. You can select which shell you would like the terminal to default to in your User Settings using the `terminal.integrated.shell.linux` attribute. By default, the terminal will default to Bash on Linux and macOS or Powershell on Windows.

![Terminal Example](/assets/images/blog/integrated-terminal-example.png)

### C#/.NET Core

If you want to develop for .NET Core in Linux, VS Code offers perhaps the best experience. Full debugging and intellisense are provided by Omnisharp by installing the [C# plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp).

### Performance

One of the common complaints against Atom is its slow load time and it's difficulty with large files. Being based on Atom, you'd think that VS Code would suffer from the same sluggish behaviour, but I haven't found that to be the case. VS Code starts in under a second on my machine, which is something that.