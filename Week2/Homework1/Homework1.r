## Solutions for Homework 1

###									Setting up the file and variable names

# Firstly , we will read in the songs csv file
songs = read.csv('songs.csv')

## -----------------------------------------------------------------------------------------------------------------------------

## Problem 1

## Firstly , we have to find out the number of observations for the year 2010 . There are two ways to do this .

## First method is to create a subset in which we would only have observations of the year 2010 .
songs_2010 = subset( songs , year == 2010 )
str(songs_2010)

## However , the method would only give us the observations for a specific year . To get the number of observations for all years
## it is better to create a table .
table(songs$year)

## Then we have to find out the number of songs in which the artist was Michael Jackson . We can again do this by two ways.

## One method is to create a subset of the dataset containing only those records where the artist name is Michael Jackson.
Michael_Jackson = subset( songs , year == 2010 )
str(Michael_Jackson)

## Another is to create a table of the artists name table . However , since the number of artists is a big number , finding one
## of them would be a tedious task.
table(songs$artistname)

## Next , we have to find what are different factor values which timesignature takes and what is the frequency for each .
## For that , we can simply create a table of the timesignature feature .
table(songs$timesignature)

## After that , we want to find out the name of the song which has the highest tempo. For that , we first find the row number 
## for which the tempo is maximum and then we find the song name corresponding to that row number .
tempo_max_row = which.max(songs$tempo)
max_tempo_song = songs$songtitle[tempo_max_row]

## -----------------------------------------------------------------------------------------------------------------------------





