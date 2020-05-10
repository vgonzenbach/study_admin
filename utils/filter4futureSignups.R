"Filter most recent signups to online questionnaire, aggregate into 
two quasi-experimental conditions and produce table of emails addresses."

#add line for looking into latest occur_date on SEASinvited.csv
library(dplyr)
sign.ups = read.csv("./DATA/roster_download_737.csv", stringsAsFactors = FALSE)
sign.ups$occur_date = as.Date(sign.ups$occur_date, format = "%m/%d/%y")

#grab records from this year that have been 
signups.future = sign.ups %>% filter(occur_date > Sys.Date(), 
                                     occur_date < Sys.Date() + 7,
                                       credit_type %in% c("Awaiting Action"))

#match with SEAS I record
index4future.id = match(signups.future$login_id, tolower(SEAS$NetID)) 
index4future.email = match(signups.future$email, tolower(SEAS$email))

#check which index is more complete
future.df = cbind(X = index4future.id, 
                  condition = numeric(length(index4future.id)), 
                  SEAS[index4future.id,])

future.df %>% get.hi.schz() %>% sum() #3
future.df %>% get.lo.schz() %>% sum() #7

#total schizotypy 65
#total control 57

#invite 10 schizotypy
#invite 18 control








