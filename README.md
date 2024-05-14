# College Api search mini app

Small api to conform to these specs

> ## College Search
> Note: you'll need to get an API key (simple to do) from the services provided below:
>
> Using the College Scorecard API provided by the department of education, please create a page that includes:
>
> 1. A search box for college names
> 2. Use Google Maps to display the location of each college returned
>
> ### Reference
>
> https://collegescorecard.ed.gov/data/documentation/
> https://github.com/RTICWDT/open-data-maker/blob/master/API.md

## Instructions

Clone the repo:

> git clone git@github.com:leanucci/ent3rai-api-search.git

then

> cd ent3rai-api-search
> bundle
> CSD_API_KEY=YOUR_API_KEY bundle exec rerun ruby app.rb

The `rerun` command can be ommitted, its only useful for making changes with automatic restarting

## What I did

* Since the request has barely any constraints, I erred on the side of simplicity, completeness and delivery
time
* I left out the api key from the codebase
* Google maps api supports different ways to generate a valid url to a College, I decided to use a unique
  search term so that the pinned location in the map includes useful information
* I added super simple reverse caching for the api results
* No tests. Test setup would take way longer than writing tests for existing code, but this is the first thing
  to do if this api were to extend
* This is just a conversation starter. As more constraints appear, more interesting decissions can be made.
  Lets discuss!

