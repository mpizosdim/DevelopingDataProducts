Developing Data Products
========================================================
author: Dimitrios Bizopoulos, Mechanical Engineer
date: Mon Aug 10 16:57:47 2015

KilledbyPolice.net Database
========================================================
type: sub-section

This presentation is created as part of the Project assignment for the course *Developing Data Products* from Coursera. The tasks of the project is to:

- Build a **shiny** data application
- Create a presentation conserning the application using **R-presenation**


Development
========================================================
type: sub-section

Using row data taken from [KilledbyPolice](http://www.killedbypolice.net/) and using some text scraping technicies to clean the data an application was implimented to visualize the database. The application can be found in www.dbizopoulos.com. The code of the data can be found in [Github:mpizosdim](https://github.com/mpizosdim/DevelopingDataProducts).

Application
========================================================
type: sub-section

The applciation  allows the user to:

- Select inputs such as year,race or sex to visualize 
in the MAP of US the people killed by the police in every state
- Interesting tables for the data
- Check interesting plots of the data.
- About page explaining the application.


Data
========================================================
type: sub-section

The data extracted by the site www.killedbypolice.net was modified and cleaned to get the following format:


```
  X       Date Age  Race  Sex   region
1 1 2013-05-01  26  <NA> Male michigan
2 2 2013-05-02  59  <NA> Male    texas
3 3 2013-05-02  40  <NA> Male new york
4 4 2013-05-02  NA Black Male    texas
5 5 2013-05-02  38 Black Male oklahoma
6 6 2013-05-02  22  <NA> Male  indiana
```
