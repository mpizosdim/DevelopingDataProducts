---
title: "Untitled"
author: "Bizopoulos Dimitrios"
date: "Wednesday, August 05, 2015"
output: html_document
---

## US Police kills: Database from 2013 to 2015

### Application

This application visualize the kills that are reported to be done by US police from May 2013 till August of 2015. The data have been taken by the [killedbyPolice](http://www.killedbypolice.net/) website.  I the github repository there is also a small R presentation in the github explaining the application.

To get and clean the data from this site various technics were used including `readLines` from the base library to get the html code and `gsub` and ` regmatches` functions to extract info and store it to a data frame. The final Data have the following format:


```{r}
  X       Date Age  Race  Sex   region
1 1 2013-05-01  26  <NA> Male michigan
2 2 2013-05-02  59  <NA> Male    texas
3 3 2013-05-02  40  <NA> Male new york
4 4 2013-05-02  NA Black Male    texas
5 5 2013-05-02  38 Black Male oklahoma
6 6 2013-05-02  22  <NA> Male  indiana
```

Furthermore, the US states populations as well as the distribution of the races in Us is taken by the wikipedia site: [Demographics of the United States](https://en.wikipedia.org/wiki/Demographics_of_the_United_States]) You can find the code to exctarct the data, as well as the application, in my github account [Github:mpizosdim](https://github.com/mpizosdim/DevelopingDataProducts). For more info feel free to contact me in my mail account: dimitrisbizopoulos@gmail.com .


## US Map

In this tab panel there are three figures. The figure 1 shows the population of the states of the US. The figure 2 shows the number of kills that are reported to be done by US police and the figure 3 shows the rate of kills devided by the population of each state ( multiplied with the factor 10^6, as the rates is small). 

The user has the option to choose:

* the period that the kills have been commited( from 2013 to 2015).
* The range of age of the people that have been killed.
* The race and the compination between them.
* The sex: Male or Female

## Plots

In this tab panel the user can observ various plots and pie charts. The first figure is a time series of the comulative kills that have been done by US police from 2013 to 2015. The next figure shows the distribution of the kills as a factor of the race. The last figure is pie charts that shows the kills as a a factor of the Sex.

## Tables

The table tab panel have 2 tables:

* Table 1 shows the Rate of people killed by Race.
* Table 2 shows the Rate of people killed as a factor of the Sex: Male or Female.
