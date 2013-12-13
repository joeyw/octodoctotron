# octodoctotron

Welcome to this fun experiment in helping those new to Octokit quickly find all
the GitHub API methods they need to create new projects that change the world.

How are we going to do it? We're going to make some magic that shows Octokit
method names in the GitHub API docs that link to their respective Octokit
methods.

Octokit is well documented, but the GitHub API docs are sexy and I'd rather look
through them. Does that make me shallow? Maybe, octobiteme.

## octodoctotron in action

![GitHub API docs before](/build/screenshots/api-docs-before.png?raw=true)
![GitHub API docs after](/build/screenshots/api-docs-after.png?raw=true)

## Installation

While this is still an experiment, you can install this chrome extension the
developer way.

Clone down the repo.

Go to [chrome://extensions](chrome://extensions).

Enable developer mode.

Click load unpacked extension, point to `octodoctotron/build/chrome-extension`.

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
