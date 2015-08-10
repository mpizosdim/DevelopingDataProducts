library(shiny)
library(ggplot2)
library(maps)
library(rCharts)
library(reshape2)
source('PlotsPoliceProj.R')
all_states <- map_data('state')
all_states <- all_states[all_states$region!="district of columbia",]
Data <- read.csv('data.csv')
Data$Date <- as.Date(Data$Date)
Populations <- read.csv('USpopulations.csv')

RacePopulation <- data.frame(Race=c('White','Black','Other','Asian','Latin'),Pop=c(197870516,42020743,9146431,18205898,53986412))
SexPopulation <- data.frame(Sex=c('Male','Female'),Pop=c(158169086,163060914))
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    
    Data2 <- reactive({
        temp <- Data[Data$Date >= input$YearRange1 & Data$Date <= input$YearRange2 & Data$Age >= input$AgeRange[1] & Data$Age <= input$AgeRange[2] & Data$Race %in% input$Race & Data$Sex %in% input$Sex,]
        temp
    })
    
    
    
    
    
    
    output$Agehistogram <- renderChart({
        Data1 <- Plot1Manipulate(Data)
        Agehistogram <- nPlot(value ~ Week,group='variable',data = Data1,type = "lineChart",dom ='Agehistogram',width = 650)
        Agehistogram$chart(margin = list(left = 100))
        Agehistogram$yAxis( axisLabel = "Deaths", width = 80)
        Agehistogram$xAxis( axisLabel = "Week", width = 70)
        return(Agehistogram)
    })
    
    output$PieChart <- renderChart({
        PieChart <- nPlot(~ Race,data=Data,type='pieChart',dom='PieChart')
        PieChart$chart(margin = list(left = 100))
        return(PieChart)
    })
    
    output$PieChart2 <- renderChart({
        PieChart2 <- nPlot(~ Sex,data=Data,type='pieChart',dom='PieChart2')
        PieChart2$chart(margin = list(left = 100))
        return(PieChart2)
    })
    
    #output$PieChart3 <- renderChart({
    #    DeathsPerState <- summaryBy(Age~Race,data=Data,FUN=c(length))
    #    DeathsPerRace <- merge(DeathsPerState,RacePopulation,by='Race')
    #    DeathsPerRace$Rate <- DeathsPerRace$Age.length/DeathsPerRace$Pop
    #    PieChart3 <- nPlot(~Rate,data=DeathsPerRace,type='bar',dom='PieChart3')
    #    PieChart3$chart(margin = list(left = 100))
    #    return(PieChart3)
    #})
    
    
    
    #output$Histogram1 <- renderChart({
     #   lol <- summaryBy(.~Age+Sex,data=Data,FUN=length)
     #   Histogram1 <- nPlot(X.length~ ,group='Sex',data=lol,type='bar',dom='Histogram1')
     #   Histogram1$chart(margin = list(left = 100))
     #   return(Histogram1)
    #})
   
    output$Map <- renderPlot({
        states <- data.frame(state.center, state.abb)
        
        Data3 <- Data2()
        DeathsPerState <- summaryBy(Age~region,data=Data3,FUN=c(length))
        State2 <- data.frame(state.center,region = tolower(state.name))
        State2 <- merge(State2,DeathsPerState,by='region')
        Total <- MapFunction(Data3)
        Total <- Total[order(Total$order), ]
        p <- ggplot()
        p <- p + geom_polygon(data=Total, aes(x=long, y=lat, group = group, fill=Age.length),colour="white"
        ) + scale_fill_continuous(low = "thistle2", high = "darkred", guide="colorbar")
        P1 <- p + theme_bw()  + labs(fill = "Number of Killed people" 
                                     ,title = "Number of People killed by police(Fig 2)", x="", y="")
        #P1 <- P1 + scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) + theme(panel.border =  element_blank())
        P1 <- P1 + labs(x = "Long", y = "Lat")
        P1 <- P1 + geom_text(data = State2, aes(x = x, y = y, label = Age.length, group = NULL), size = 2)
        print(P1)
    })
    
    
    output$Map2 <- renderPlot({
        states <- data.frame(state.center, state.abb)
        Populations$Population2 <- Populations$Population/1000000
        Total2 <- merge(all_states,Populations,by='region')
        Total2 <- Total2[order(Total2$order), ]
        p <- ggplot()
        p <- p + geom_polygon(data=Total2, aes(x=long, y=lat, group = group, fill=Population2),colour="white"
        ) + scale_fill_continuous(low = "thistle2", high = "darkred", guide="colorbar")
        P2 <- p + labs(fill = "Population in Millions" 
                                     ,title = "Population per State(Fig 1)", x="", y="")
        #P2 <- P2 + scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) + theme(panel.border =  element_blank())
        P2 <- P2 + labs(x = "Long", y = "Lat")+theme(legend.position="bottom")
        P2 <- P2 + geom_text(data = states, aes(x = x, y = y, label = state.abb, group = NULL), size = 2)
        P2 <- P2 + theme(plot.background = element_rect(fill = rgb(245,245,245,maxColorValue=255)),panel.background = element_rect(fill = rgb(245,245,245,maxColorValue=255)))
        print(P2)
    })
    
    
    output$Map3 <- renderPlot({
        
        
        Data3 <- Data2()
        State2 <- data.frame(state.center,region = tolower(state.name))
        
        DeathsPerState <- summaryBy(Age~region,data=Data3,FUN=c(length))
        Total3 <- merge(Populations,DeathsPerState,by='region')
        Total3$Rate <- round(Total3$Age.length/Total3$Population*1000000,3) 
        State2 <- merge(State2,Total3,by='region')
        #State2$Rate <- round(State2$Rate,digits=4)
        Total3 <- merge(all_states,Total3,by='region')
        Total3 <- Total3[order(Total3$order), ]
        p <- ggplot()
        p <- p + geom_polygon(data=Total3, aes(x=long, y=lat, group = group, fill=Rate),colour="white"
        ) + scale_fill_continuous(low = "thistle2", high = "darkred", guide="colorbar")
        P3 <- p + theme_bw()  + labs(fill = "Rate of Kills per Population" 
                                     ,title = "Rate of people killed by police per state( multiplied with 10^6)(Fig 3) ", x="", y="")
        #P3 <- P3 + scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) + theme(panel.border =  element_blank())
        P3 <- P3 + labs(x = "Long", y = "Lat")
        P3 <- P3 + geom_text(data = State2, aes(x = x, y = y, label = Rate, group = NULL), size = 2)
        print(P3)
    })
    
    output$dTable <- renderTable({
        DeathsPerState <- summaryBy(Age~Race,data=Data,FUN=c(length))
        DeathsPerRace <- merge(DeathsPerState,RacePopulation,by='Race')
        DeathsPerRace$Rate <- (DeathsPerRace$Age.length/DeathsPerRace$Pop)*1000000
        DeathsPerRace
    } #, options = list(bFilter = FALSE, iDisplayLength = 50)
    )
    
    
    output$dTable2 <- renderTable({
        DeathsPerSex <- summaryBy(Age~Sex,data=Data,FUN=c(length))
        DeathsPerSex <- merge(DeathsPerSex,SexPopulation,by='Sex')
        DeathsPerSex$Rate <- (DeathsPerSex$Age.length/DeathsPerSex$Pop)*1000000
        DeathsPerSex
    } #, options = list(bFilter = FALSE, iDisplayLength = 50)
    )
    
    
})