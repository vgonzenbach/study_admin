"Assign experimental conditions and record assignment on table"

# 1. update roster_download_737.csv (download from SONA)
# 2. update SEASinvited.csv
source("filter_schz.R")
library(dplyr)
SEAS.invited = read.csv("SEASinvited.csv", check.names = FALSE)
SEAS.invited$RecordedDate = as.Date(SEAS.invited$RecordedDate, format = "%m/%d/%y")

#check this before inviting more participants!!
list(remaining.hi.p = 75 - sum(get.hi.schz(SEAS.invited)), remaining.lo.p = 75 - sum(get.lo.schz(SEAS.invited)))

#count conditions in each level of schizotypy
remaining.BLERT.hi = 25 - table(SEAS.invited[get.hi.schz(SEAS.invited), "condition"])
remaining.BLERT.lo = 25 - table(SEAS.invited[get.lo.schz(SEAS.invited), "condition"])

#create bag of conditions from which to draw
hi.condition.bag = c(rep(1, remaining.BLERT.hi[1]),
                     rep(2, remaining.BLERT.hi[2]),
                     rep(3, 0)) #remaining.BLERT.hi[3]

lo.condition.bag = c(rep(1, remaining.BLERT.lo[1]),
                     rep(2, remaining.BLERT.lo[2]),
                     rep(3, remaining.BLERT.lo[3]))

#sample for conditions for future participants
#source("filter4futureSignups.R") #make this a function
#
##draw from correct "bag" 
set.seed(42)
future.df$condition[get.hi.schz(future.df)] = sample(hi.condition.bag, 
                                                     sum(get.hi.schz(future.df)), 
                                                     replace = FALSE)
future.df$condition[get.lo.schz(future.df)] = sample(lo.condition.bag, 
                                                     sum(get.lo.schz(future.df)), 
                                                     replace = FALSE)

write.csv(rbind(SEAS.invited, future.df[,(future.df %>% colnames()) %in% (SEAS.invited %>% colnames())]), "updated_SEASinvited.csv", row.names = FALSE)

#save csv
#visualize ones to be assigned for calendar invite




