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
