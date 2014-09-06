Castle project
==============

Short project looking at the genders of killers and victims in the TV show Castle.

What's in this repo
===================

/Data has three files: 
- "roles.csv" contains data taken from Castle Wikia and extracted with Google Refine.
- "genders.csv" contains data from imdb about the Castle cast.
- "USMurderStats1980-2008.csv" contains data from the US Department of Justice relating to murders.

/RScripts contains scripts that munge the above data and produce a plot.

To run the scripts
=================

From the root of the project, run "Castle.R". This script will combine the data in "roles.csv" and "genders.csv", and produce NA in instances where this is not possible.

Run "addMissingValues.R" to replace NA with appropriate values in gender field.

Run "createPlot.R" to produce plot showing a gender breakdown of killers and victims in Castle, and US murder cases.

Output
======

The outputted files:
- "gendersWithRolesIncludingNAs.csv" data set produced as a result of merging "roles.csv" and "gender.csv". Contains NA values where a merge was not possible.
- "gendersWithRolesComplete.csv" updated data set containing relevant genders in place of NA values.
- "castlePlot.png" plot showing the genders of victims and killers in Castle next to stats from the US Department of Justice.
