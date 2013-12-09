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
