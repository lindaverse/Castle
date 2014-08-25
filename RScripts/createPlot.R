require(ggplot2)
require(scales)

#Load US homicide data into R.
crimeStats <- read.csv("./Data//USMurderStats1980-2008.csv", header=T)

#Subset Caslte data to Killer and Victim roles.
victims <- gendersWithRolesIncomplete[gendersWithRolesIncomplete$role=="Victim",]
killers <- gendersWithRolesIncomplete[gendersWithRoles$role=="Killer",]

#Remove rows where gender is NA.
victims <- victims[!is.na(victims$gender),]
killers <- killers[!is.na(killers$gender),]

#Percentage breakdown by gender and roles.
percentageBreakdownVictims <- victims[, list(percentage=as.numeric(.N/nrow(victims))*100), by=list(gender, role)]
percentageBreakdownKillers <- killers[, list(percentage=as.numeric(.N/nrow(killers))*100), by=list(gender, role)]

#Combine into data table.
castleRoleGenderBreadkdown <- rbind(percentageBreakdownVictims, percentageBreakdownKillers) 

#Add variable indicating data source.
castleRoleGenderBreadkdown$context <- c("Castle")
crimeStats$context <- c("Actual")

#Merge "real life" and Castle data and order by gender variable.
allData <- rbind(crimeStats, castleRoleGenderBreadkdown, use.names=T)
allData <- allData[order(allData$gender),]

#Set role and gender factor variables.
allData$role <- as.factor(allData$role)
allData$gender <- as.factor(allData$gender)

#Create plot comparing actual homicides to Castle data and output it to png file. 
png("plot5.png", width=600, height=600)
print(ggplot() +
        geom_bar(data=allData, 
                 aes(y = percentage, 
                     x = context, 
                     fill = gender), 
                 stat="identity",
                 position='stack') + 
        ylab("Percentage") +
        xlab(NULL) +
        theme(legend.position="bottom") +
        scale_fill_discrete(labels=c("Female", "Male")) +
        theme(panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank()) +
        facet_grid( ~ role))
dev.off()
