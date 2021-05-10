# Stan (on Rails)
The Trinity Oxley CC "Statistical Goldmine"
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