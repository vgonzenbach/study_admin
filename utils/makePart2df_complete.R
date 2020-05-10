#makePart2.df
require(qualtRics)
require(dplyr)

#Objective: put together dataframe with complete data for every participant of part2

#download Lab session from Qualtrics
Lab = fetch_survey(surveyID = 'SV_1EUBbg4eC8ZsuNf', 
                   verbose = TRUE,
                   force_request = TRUE,
                   save_dir = "../Part 2/DATA")

DE = fetch_survey(surveyID = 'SV_7UMulij1kNHvsyh', 
             verbose = TRUE,
             force_request = TRUE,
             save_dir = "../Part 2/DATA")

Master = read.csv("DATA/Undergrad Master Recruitment.csv")

#match Lab ID with  for IDs
ids = Master[Master$LAB.ID %in% Lab$ID, c("LAB.ID", "EMAIL", "NetID")]

#order SEAS.2 by order in Master Recruitment
index.id = match(ids$NetID, tolower(SEAS$NetID))
index.em = match(ids$EMAIL, tolower(SEAS$email))
index.joined = index.id

for(i in 1:length(index.joined)){
  if(index.joined[i] %>% is.na()){
    index.joined[i] = index.em[i]
  }
  i = i + 1
}

SEAS.2 = SEAS[index.joined, ]

SEAS.2 = cbind(condition = numeric(nrow(SEAS.2)), SEAS.2)

SEAS.2$condition[index4SEAS.2] = SEAS.invited$condition

SEAS.2 %>% View()


