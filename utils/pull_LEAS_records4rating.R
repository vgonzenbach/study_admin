"Randomly draw 5 LEAS responses for each schizotypy group
#1. match subject IDs to an experimental group
#2. randomly draw 5 indices from each group
#3. Pull LEAS according to index"
library(dplyr)
library(readxl)
library(writexl)

surveyID = 'SV_1EUBbg4eC8ZsuNf'
# Pull Lab Session Dataframe
df_lab = as.data.frame(fetch_survey(surveyID, 
                      save_dir = 'DATA',
                      #force_request = TRUE,
                      time_zone = 'America/Chicago'))


#grab ids from IRR assignment
already_scored = read.csv("LEAS Scoring/IRR/LEAS_for_interrater_reliability.csv", stringsAsFactors = FALSE)$ID

#grab ids from Phase one assignment
phase_one = read.csv('LEAS_for_Mon16.csv', stringsAsFactors = FALSE)
already_scored = c(already_scored, phase_one$ID)

#omit already scored
ids4scoring = df_lab[!df_lab$ID %in% already_scored, "ID"]

LEAS4deadline = df_lab[match(ids4scoring, df_lab$ID), ] %>% 
  select(ID, starts_with("LEAS")) %>% 
  arrange(ID)

LEAS4deadline = cbind(scorer1 = character(length = nrow(LEAS4deadline)), 
                      scorer2 = character(length = nrow(LEAS4deadline)),
                      LEAS4deadline)
LEAS4deadline$scorer1 = as.character(LEAS4deadline$scorer1)
LEAS4deadline$scorer2 = as.character(LEAS4deadline$scorer2)
scorers = c("AG", "AQ", "MI", "NN", "SG")

bag_scorers = rep(scorers, as.integer(nrow(LEAS4deadline)/5))

LEAS4deadline$scorer1[1:80] = sample(bag_scorers, replace = FALSE)
LEAS4deadline$scorer2[1:80] = sample(bag_scorers, replace = FALSE)

for(i in 1:nrow(LEAS4deadline[1:80,])){
  if(LEAS4deadline$scorer1[i] == LEAS4deadline$scorer2[i]){
    LEAS4deadline$scorer2[i] = sample(scorers[!scorers %in% LEAS4deadline$scorer2[i]], size = 1)
  }
}


write.csv(LEAS4deadline, "new_LEAS4deadline.csv")
already_scored = c(already_scored, LEAS4deadline$ID)
saveRDS(already_scored, "LEASassigned.rds")

#reload file after manual modification
LEAS4deadline = read.csv("new_LEAS4deadline.csv")
indv_assign = vector(mode = "list", length = 5)
names(indv_assign) <- scorers
for(i in 1:length(scorers)){
  indv_assign[[i]] = LEAS4deadline %>% 
    filter(scorer1 %in% scorers[i] |
           scorer2 %in% scorers[i]) %>% 
    select(-scorer1, -scorer2)
  writexl::write_xlsx(indv_assign[[i]], paste0("LEAS scoring/", scorers[i], "_LEAS_new", ".xlsx"))
  i = i + 1
}

#SAVE
#individually
for(i in 1:length(scorers)){
  
}

#all
write.csv(LEAS4deadline, "LEAS_for_April16.csv", row.names = FALSE)

?write_xlsx

