library(shiny)
library(rCharts)
# Define UI for application that draws a histogram
shinyUI(
    navbarPage('Killed by Police in US 2013-2015: Database Explorer',
               tabPanel('US map',
                        sidebarPanel(dateInput('YearRange1','Start Year:',min='2013-05-01',max='2015-08-04',value='2013-05-01'),
                                     dateInput('YearRange2','End Year:',min='2013-05-01',max='2015-08-04',value='2015-08-04'),
                                     sliderInput('AgeRange','Age Range:',min=0,max=100,value=c(0,100)),
                                     checkboxGroupInput("Race", "Race:",
                                                        c("White" = "White",
                                                          "Black" = "Black",
                                                          "Asian" = "Asian",
                                                          'Latin' = 'Latin',
                                                          'Other' = 'Other'),
                                                        selected=c('White','Black','Asian','Latin','Other')),
                                     checkboxGroupInput("Sex", "Sex:",
                                                        c("Male" = "Male",
                                                          "Female" = "Female"),
                                                        selected=c('Male','Female')),
                                     plotOutput('Map2')
                                     ),
                        mainPanel(
                            h3('Us Map database'),
                            plotOutput('Map'),plotOutput('Map3')
                            )
                                      
                        
                        ),
               
               tabPanel('Plots',h4('Time Series of Killed People by Police in US',align = 'center'),showOutput("Agehistogram", "nvd3"),
                        h4('Pie Chart: People Killed by Race',align = 'center'),showOutput("PieChart", "nvd3"),
                        h4('Pie Chart: Killed by Sex',align = 'center'),showOutput("PieChart2", "nvd3")),
               tabPanel('Tables',tableOutput("dTable"),tableOutput("dTable2")),
               tabPanel('About',mainPanel(includeMarkdown('ReadMe.Rmd')))
               )
    
    
    
    
    )