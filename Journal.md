CHAPTER I
================================================================================

Hello Friendo. I have just embarked on a small side project to make it super
easy for anyone browsing the GitHub API documentation to quickly find the
Octokit.rb methods that correspond to each API endpoint.

I'm starting this journal as I start the project to document my though proces
and satisfy my own curiosity at the same time. I have used the GitHub API and
have contributed a small bit to Octokit.rb in the past so I am familar with each
fairly well. Once you start using both you get a feel of how the method name
that responds to each api resource. I'm sure there is some unix philosophy in
there about things being what you would expect them or something. I have
terrible selective memory so that may or may not make sense or even exist. Being
the case though sometimes I can't guess the octokit method for api resources and
maybe others have this problem too so here we are.

A quick visit to GitHub and the repo for this project was born the easy way,
even taking the swanky name fuzzy-octo-happiness suggested after several
refreshes. A quick gitub search shows five other projects elected for the same
name. Lettuce see if we can make the name mean something more than just empty
test repos.

CHAPTER II
================================================================================

I've spent a little while thinking about how this could work. We have the
Octokit source code full of comments above their methods that include links to
the API docs that the method accesses. The first thing that comes to mind is
coming up with some sort of search method to get the link and the method name
associated. Maybe sometihng simple like a search for the api url then take the
next defined method name to link them. This is going to be the first thing I
explore with code.

On the API docs side of things I am thinking of some magical javascript to solve
all my problems. All the methods include links that will easily be able to be
picked up with javascript. With the link and method name we will be able to
easily inject some html of our own with the method name linked back to the
Octokit documentation.

CHAPTER III
================================================================================

With last chapters thoughts in mind it is time to start exploring them with a
little bit of code. I've added some skeleton to the project to get things
rolling. For now I am going to kick the tires in ruby and see what we can come
up with. I am going to use the `gem content` command to get a list of all the
octokit source files then explore a few searching options here on the `method-
and-url-searcher` branch.

I am working on searching/parsing the Octokit source files and now realizing the
links to the Octokit docs will have to be parsed separately after being
generated. In which case it might be easier to just parse the Octokit docs to
get all the data at once. After peeking at the generated docs html I am going to
put that approach in the back of my mind. After that quick look that approach
looks pretty daunting and would be over complicated but I could see it working.
For now I am going to focus on something much simplier by keeping at the source.
I should be able to trivially generate the urls myself since they come from the
ruby source in the first place.

In the spirit of making things simplier I am going to forget the link to the
Octokit docs for now. Knowing the method name is good enough since it is easily
searchable.

Now, what we're looking to get from the source files seems very simple. A URL
and a method name. Now we know what we have and what we want it is time to whip
up some tests and get the data we want.

I've just commited the first iteration of [the
extractor](https://github.com/joeyw/fuzzy-octo-happiness/commit/319ccf9f75cb17).
It is quite horrible but a starting place at least. Extracting data is pretty
tricky it seems. I am trying to avoid regex where possible. Looking at several
different source files I am seeing a lot of edge cases I didn't think of when I
first imagined how this would work.

CHAPTER IV
================================================================================

Now that I have a basic idea of the data we will be getting from the extractor,
I am going to tinker with the API docs side of things where we'll be using that
extracted data and injecting it into the pages.

Here is the data were currently working with:

```json
[{
	"api_url": "http://developer.github.com/v3/meta/#meta",
	"method_name":"meta"
}]
```

The API docs graciously provide easily accessible anchors for each API endpoint.

```html
<h1 id="meta">
	<a class="header-anchor" href="#meta">::before</a>Meta
</h1>
```

Since the Octokit team has been diligent in the docs about including specific
links to each anchor id on the docs pages we can simply get id from the url and
use it to inject our html directly below the docs header for that endpoint.

Now that I've played with the docs a small bit, this is what I've come up for
inserting the method name:

```javascript
$('#meta').after('
	<div>
		<code>Octokit.rb: <a href="#" target="_blank">Octokit#meta</a></code>
	</div>
');
 ```

Linking to the Octokit docs is on the backburner at the moment so we'll have to
add it later.

I've just completed a [basic injector the the API docs][1]. I like it. I am
likely going to change the data structure being returning from the extractor to
make using it a little bit nicer but that isn't a high priority right now.

[1]: https://github.com/joeyw/fuzzy-octo-happiness/commit/93e2ebe6e77256e9102019

Now I am going to make a small build script that turns the injector code into a
bookmarklet for now, depending on how this all goes I'll likely throw it in a 
chrome extension just to be fancy.

Apparently you can't paste a javascript url into the chrome address bar. Fun
stuff.

Just completed the small build script for the injector, it should be enough for
now. Well, almost completed. I need to make a script for the extractor that
outputs the json result from the process then use that data in the build script
to inject the extracted data. Right now it is hardcoded just for the single meta
method.

I thought copying to clibboard was neat but it broke so I removed it.

CHAPTER V
================================================================================

Were on our way now. We have a working basic prototype. The data is still
provided manually to the bookmarklet but that is about to change. We're going to
modify the build script to insert the extracted data into the bookmarklet.

I just finished adding to the build script. It now extracts the data from
Octokit.rb, then uses it to generate the client side code and bookmarklet.

Now we need the actual parser to not completely suck. Right now it is very
flakey.

CHAPTER VI
================================================================================

This is a short chapter. All I report is that I am seriously considering the
name OctoDoctoTron. Maybe OctoDoctoBot. Something along those lines at least.
Hmmm d hmmm hummm.

CHAPTER VII
================================================================================

Back to getting stuff done. Instead of making fixtures for the source files for
the tests I am going to test directly against the octokit files. The thinking 
behind it is that I can tell when stuff breaks when octokit changes.

With the parser improved, most of the api docs to octokit docs are working. This
project might not be important or exciting to anyone else besides me, but for 
me right now, I just needed to build something. I gave up on a lot of projects
in the past that I started out excited about but eventually started having
doubts about it. I've had these same doubts about this project. But making stuff
has been enough reason to keep going, for that good feeling of satisfaction of
making this humble little computer do something. Going to the api docs and
clicking that bookmarklet to see the octokit methods appear is simple, but oh so
satisfying. I haven't made anything in a long time and that alone makes this
project important to me regardless of how much of an impact the project itself
has on anyone else. For now I am going back to work to fix a few quirks I have
on my mind.

CHAPTER VIII
================================================================================

I finally got tired of doing a lot of copy/pasting with the bookmarklet and
added the necessary files to load the injector as a chrome extension. Now is
also the time to change the name to octodoctotron. See you on the other side.

CHAPTER IX
================================================================================

Most methods now show up correctly. Just a couple edge cases left which I am
working on now. Still need to work out the links back to the octokit docs, will
work on that after the methods are all showing up correctly. If this never
experiment never takes off as a reference tool, at least it has forced me to
update a lot of the octokit docs so the urls work and therefore this extension.

With those last parser changes, it looks like all methods are showing up. I just
finished going over every page of the api docs this morning checking urls. I
probably should have made these fixes first because now I need to go over them
again to make sure everything is showing up. But for now I am working from my
bad memory of which ones I remember were not working due to the multiple url
issue.

The last two things that I need to fix before first release is checking the path
on the urls since not all the ids on the docs are unique, some use `#list` for
multiple endpoints instead of `#user-list` for example thus resulting in
methods showing up where they don't go. The other major thing is the url to the
Octokit docs. The octokit docs are generated so it should be fairly easy to do
some simple parsing to get the same url as yard generates.

The octokit docs url generator is now build and seems to be doing its job. I'll
know a bit more once I do a more thorough audit going over the api docs but just
checking a few different places it seems to be doing alright.

Now I feel the last big thing left (for now) is to make sure we aren't injecting
method names into places they shouldn't be when the anchor id is generic such as
`#list` or `get`. Not to worry, I played around with this early on but took it
out because some things weird injecting properly. So heres the second stab at
it. Were just going to add the path of the url for each method name which is
easily grabbed from the url we already have and accessible in the browser.

So close now, the major things I wanted to be ready for intial release are done.
There is still a minor parser bug that is including method that doesn't relate
to an actual api method so that will need to be fixed and then I do believe this
will be ready to be shared with those that will look at it.

CHAPTER X
================================================================================

What a fun little side project this has turned into over the past week. From
inception on Monday to its pending initial public release here on Friday. The
code may not be the most beautiful, but it works and I am not going to get hung
up trying to impress anyone. I took a long break from any kind of programming
which hurt me dearly I think, but now it is time to press on. As I start working
again I think my code will naturally improve as I am challenged to think about
new problems and challenges. If you're reading this I hope you've enjoyed it. I
haven't done any editting on this journal or even reread it entirely since I've 
written it. I've reread small pieces where I left off but that is it. Apologies
if doesn't make any sense at all, it really was most of my thoughts as I worked.
Not everything made it in, but hopefully enough did to keep you interested.
Thats all for now, it is time to push this last entry and flip the open source
switch on GitHub. Thanks for reading.
