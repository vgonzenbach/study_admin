# study_admin
R scripts for automation of various study admin tasks

# Description of Scripts

+[filter4futureSignups.R](utils/filter4futureSignups.R) filter responses from online questionnaire to send invitations 
for in-lab portion according to quasi-experimental groups.

+[assign_BLERT_experimental_condition.R](utils/assign_BLERT_experimental_condition.R) assigns experimental conditions to 
incoming participants.

+[makePart2df_complete.R](utils/makePart2df_complete.R) pulls from online, in-lab and data entry tables to create one dataset for
all participants that have completed Part 2 of the study.

+[pull_LEAS_records4rating.R](utils/pull_LEAS_records4rating.R) pulls Qualtrics surveys from visits and extracts 
participant responses to the Levels of Emotional Awareness Scale (LEAS). Then distributes these data across 5 excel tables 
for each RA to rate.

+[iccs4LEAS.R](utils/iccs4LEAS.R) pulls data from the 5 tables of ratings to calculate interrater reliability.

+[update_BLERT_transcription_checklist.R](utils/update_BLERT_transcription_checklist.R) updates an excel table 
which contains participant IDs and tracking columns. The table is used by RAs to keep track of which participant files 
need to be transcribed.

+[create_fluency_transcription_checklist.R](utils/create_fluency_transcription_checklist.R) creates and updates an excel table 
which contains participant IDs and tracking columns. The table is used by RAs to keep track of which participant files 
need to be transcript
