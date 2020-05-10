"Add new records to the BLERT transcription checklist"


library(qualtRics)
library(dplyr)
library(readxl)
library(writexl)
library(data.table)

surveyID = 'SV_1EUBbg4eC8ZsuNf'
# Pull Lab Session Dataframe
df_lab = fetch_survey(surveyID, 
             save_dir = 'DATA',
             #force_request = TRUE,
             time_zone = 'America/Chicago')

surveyID = 'SV_7UMulij1kNHvsyh'
df_entry = fetch_survey(surveyID, 
                        save_dir = 'DATA',
                        force_request = TRUE,
                        time_zone = 'America/Chicago')

#Find missing in DE
print(df_lab[!df_lab$ID %in% df_entry$LabID, "ID"])

#Look into calendar and save missing IDs where BLERT condition is 2 or 3
missing = data.frame(LabID = c("694_883", "685_883", "684_883", "661_883", "627_883"))

#Get Lab IDS from Data Entry where 2 and 3
BLERT2transcribe = as.data.frame(df_entry[df_entry$BLERT.ifelse != "Condition 1", "LabID"])

#Add missing IDS for missing record and sort
BLERT2transcribe = rbind(BLERT2transcribe, missing)
BLERT2transcribe = BLERT2transcribe[order(BLERT2transcribe$LabID),] #returns a vector

#Get current checklist
checklist = readxl::read_xlsx("updated_transcription_checklist.xlsx")

#Keep only rows in BLERT2transcribe
checklist = checklist[checklist$LabID %in% BLERT2transcribe, ]

new_IDS = BLERT2transcribe[!BLERT2transcribe %in% checklist$LabID]

new_rows = data.frame(new_IDS, `Transcribed by` = character(length(new_IDS)), `Checked by` = character(length(new_IDS)))

#column names don't match so use rbindlist
new_checklist = as.data.frame(data.table::rbindlist(list(checklist,new_rows)))

writexl::write_xlsx(new_checklist, "updated_transcription_checklist.xlsx")
