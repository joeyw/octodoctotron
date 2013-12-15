# octodoctotron

Say hello to your new GitHub API docs Octokit.rb overlord. OctoDoctoTron places
all your favorite Octokit.rb methods directly into the absolutely beautiful 
official GitHub API docs, not only do you see the methods for each API endpoint
but they link directly to their Octokit.rb docs counterpart for quick reference.

This is still an early experiment so try it at your own risk. A sneek peek of it
in action is below as well as how you can install the chrome extension.

## octodoctotron in action

![GitHub API docs before](/build/screenshots/api-docs-before.png?raw=true)
![GitHub API docs after](/build/screenshots/api-docs-after.png?raw=true)

## Installation

### Easy Mode

[Install Octodoctotron from the Chrome Web Store](https://chrome.google.com/webstore/detail/octodoctotron/aaobeelfoiokkmjgiefcfceabhnpimad?hl=en&gl=US)

### Paranoid mode

You can also download the extension file from the [octodoctotron Releases](
https://github.com/joeyw/octodoctotron/releases) page.

### Developer mode

Lastly you can install the extension unpacked by following these steps:

Clone down the repo.

Go to [chrome://extensions](chrome://extensions).

Enable developer mode.

Click load unpacked extension, point to `octodoctotron/build/octodoctotron`.

Visit [developer.github.com](http://developer.github.com) and enjoy.

## Hacking on octodoctotron

Two parts ruby to one part javascript. The data for octodoctotron is extracted
directly from the Octokit.rb source code. Ruby 2.0.0 is being used. The javascript
part is a simple chrome extension that uses the data we extract to inject the
names of Octokit methods and the links to their docs.

Clone the project then run:

	script/bootstrap

Tests are included for the ruby parts. They test directly against the code of
the latest Octokit gem. Run them with:

	script/test

The build command will extract the doc data from Octokit.rb and compile that
into the chrome extension. To build simple run:

	script/build

## How it's made

I started this project with a [journal](Journal.md) to keep track of my thoughts
and progress. Neat.
