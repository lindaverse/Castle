require(plyr)
require(data.table)

#Read data into R.
characterNames <- as.data.table(read.csv("./Data/characterNames.csv", header = T))
roles <- as.data.table(read.csv("./Data/roles.csv", header = T))

#Update meta-data.
characterNames <- rename(characterNames, 
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

characterNames$characterIndex <-normalise_col(characterNames$Name)
characterNames$episodeIndex <- normalise_col(characterNamess$Episode.Name)
imdb$character_index <- normalise_col(imdb$char_name)
imdb$episode_index <- normalise_col(imdb$ep_name)

merged_data <- merge(characters, imdb, by = c("character_index", "episode_index"), all.x = T)

keeps <- c("Name", "Episode.Name", "Role", "Season", "actor_name", "gender")
merged_data <- merged_data[keeps]

write.table(merged_data, "merged.csv", sep = ",", row.names =T)