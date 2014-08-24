require(plyr)
require(data.table)

#Read data into R.
genders <- as.data.table(read.csv("./Data/genders.csv", header = T))
roles <- as.data.table(read.csv("./Data/roles.csv", header = T))

#Update meta-data.
genders <- rename(genders, 
                         c("ep_id" = "episodeID", 
                           "ep_name" = "episodeName",
                           "season_nr" = "seasonNumber", 
                           "episode_nr" = "episodeNumber", 
                           "actor_name" = "actorName",
                           "char_name" = "characterName"))
roles <- rename(roles, 
                c("Name" = "name",
                  "Role" = "role",
                  "Season" = "season",
                  "Episode.Name" = "episodeName"))

#Function to remove white space and change characters to lowercase.
normalise_col <- function(column) {
    lowercased <- tolower(column)
    gsub("[^a-z]", "", lowercased)
}

#Normalise data that will be used to merge tables.
genders$characterIndex <-normalise_col(genders$characterName)
genders$episodeIndex <- normalise_col(genders$episodeName)
roles$characterIndex <- normalise_col(roles$name)
roles$episodeIndex <- normalise_col(roles$episodeName)

#Merge data on character name and episode name.
gendersWithRoles <- merge(roles, genders, by = c("characterIndex", "episodeIndex"), all.x = T)

#Remove un-needed variables.
toKeep <- c("name", "role", "season", "episodeName.x", "actorName", "gender")
gendersWithRoles <- gendersWithRoles[, c("name", "role", "season", "episodeName.x", "actorName", "gender"), with = FALSE]
gendersWithRoles <- rename(gendersWithRoles, c("episodeName.x" = "episodeName"))
write.table(gendersWithRoles, "./Data/gendersWithRoles.CSV", sep = ",", row.names =T)