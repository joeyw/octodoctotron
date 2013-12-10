fuzzy-octo-happiness
====================

Welcome to this fun experiment in helping those new to Octokit quickly find all
the GitHub API methods they need to create new projects that change the world.

How are we going to do it? We're going to make some magic that shows Octokit
method names in the GitHub API docs that link to their respective Octokit
methods.

Octokit is well documented, but the GitHub API docs are sexy and I'd rather look
through them. Does that make me shallow? Maybe, octobiteme.

![GitHub API docs before](/build/screenshots/api-docs-before.png?raw=true)
![GitHub API docs after](/build/screenshots/api-docs-after.png?raw=true)

## Hacking on fuzzy-octo-happiness

Ruby 2.0.0 is being used.

Clone the project then run:

	script/bootstrap

To run tests run:

	script/test

To build javascript bookmarklet:

	script/build
