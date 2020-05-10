"Create checklist excel file to track the completion of transcriptions 
protocols for the Emotion and Animal Fluency tasks"

library(dplyr)
library(writexl)
library(qualtRics)


surveyID = 'SV_1EUBbg4eC8ZsuNf'
# Pull Lab Session Dataframe
df_lab = qualtRics::fetch_survey(surveyID, 
                      save_dir = 'DATA',
                      #force_request = TRUE,
                      time_zone = 'America/Chicago')

fluency_checklist = data.frame(LabID = df_lab$ID, 
           `Transcribed by` = vector(mode = "character", length = length(df_lab$ID)), 
           `Checked by` = vector(mode = "character", length = length(df_lab$ID))
           )
fluency_checklist = fluency_checklist[order(fluency_checklist$LabID),]

writexl::write_xlsx(fluency_checklist, 'animal_checklist.xlsx')
writexl::write_xlsx(fluency_checklist, 'emotion_checklist.xlsx')
