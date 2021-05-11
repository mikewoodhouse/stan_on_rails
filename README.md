# Stan (on Rails)
The Trinity Oxley CC "Statistical Goldmine"
These notes are partly for my own reference, partly with the notion that the app will at some point be passed to a younger, more handsome individual.
# Background
The club has played since 1949. Unusually, perhaps, detailed records were kept from the start of matches played: scorebooks, filled in with pencil during the season, were carefully reconciled and inked-in (in fountain pen!) during the close season. Averages were lovingly calculated and transferred into glorious ledgers for historic data to be collated. Most of this acitivity was carried out by the original Secretary, one Stanley Oxley.
# The Records
I took over the preparation of the averages in the mid-1990s. When I was passed the collection of end-of-season averages dating back to the start of the club, I undertook to compile them into a historical database, from which the 50- and 60-year books were produced. I developed a Microsoft Access database to handle data entry and storage. For a single user with what was effectively an update-only application, Access has been more than adequate for over 20 years.
# The Books
Statistical compendia have been produced at various points, most recently at 50 and 60 years (these two by me, the last one still available for print-on-demand at https://www.lulu.com/account/projects/1kvpd24k)
# The Web - "Stan"
At time of writing, the 75-year anniversary looms and my day-to-day involvement with the club is on the wane; I'm not officially "retired" but I have little to contribute on the playing side (many might assert that it was ever thus, and the statistics sadly do not lie in this regard). It occurred to me that all this data (with the possible addition of some match-by-match records over the last 20-odd years) could be made available via a web app. Hence this project...
## Data
### Historic - Season-by-season
The historic MS Access database tables have been exported in CSV format for import into SQLite. The files are checked into `public/csvdata`. Players were identified by four-letter codes, usually (but with many exceptions) constructed as three from the surname plus an initial, hence "Mike Bowers" is "bowm". I'm not sure yet whether to preserve that, at the cost of additional primary/foreign key specifications in the models, or to migrate towards using integer ids. At present `import.rake` applies `player.id` by cross-referencing to a player code/id lookup, so potentially at least either an id or code might be used.
### Match Data
I have a fair amount of detail at the match level from about 1995 onwards, available in the Excel spreadsheets I used from then to produce the season averages. Longer term, I have a (somewhat vague as yet) plan to import that data and make it available via Stan.
# To-Do List
In no particular order...
   1. A lot of the pages really need some parameterisation, filters, etc. For example, there are a ton of people who've played one match: we probably don't need to see those unless we demand to do so. Maybe a five-match minimum default?
   2. Player performance career summary. Perhaps calculated when performance records are selected? In `Player`?
   3. Finish the imports
   4. Refactor the `import` routine, it's not very cohesive. Do individual tables really need their own tasks? Could be DRYer with just the specs being passed in turn to, perhaps an `Importer` object?
   5. Lots more reports, ideally to cover at least the full set printed in the 60-year book (some additional data might need to be sourced for total coverage)
   6. Look at migrating the whole thing to a SPA in some way. (Very blue-sky, this). Even further, could it be an even more static site (so potentially hosted somewhere like GitHub at minimal/no cost?) using something like this: https://phiresky.github.io/blog/2021/hosting-sqlite-databases-on-github-pages/
   7. Match data (see above). How best to handle extract-transform-load, what structure to use, how to incorporate it into everyting else. Reconciliation issues?
   8.
