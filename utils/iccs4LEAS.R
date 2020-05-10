"Calculate interrater reliability for LEAS ratings for 5 undergraduates

Takes 5 excel sheets (one per RA) and matches the corresponding scores to 
calculate interater reliability using the 'irr' package"
library(readxl)
library(dplyr)
library(irr)
setwd("LEAS scoring/IRR/")

AG_scores = readxl::read_excel("AG_LEAS scoring sheets.xlsx", sheet = 1)
AQ_scores = readxl::read_excel("AQ_LEAS scoring sheets.xlsx", sheet = 1)
MI_scores = readxl::read_excel("MI_LEAS scoring sheets.xlsx", sheet = 1)
NN_scores = readxl::read_excel("NN_LEAS scoring sheets.xlsx", sheet = 1)
SG_scores = readxl::read_excel("SG_LEAS scoring sheets.xlsx", sheet = 1)

#how to calculate the self, other and total score
self.index =  seq(from = 2, by = 3, to = ncol(AG_scores))
other.index = seq(from = 3, by = 3, to = ncol(AG_scores))
total.index = seq(from = 4, by = 3, to = ncol(AG_scores))

LEAS = data.frame(AG_self  = rowSums(AG_scores[, self.index]),
           AG_other = rowSums(AG_scores[, other.index]),
           AG_total = rowSums(AG_scores[, total.index]),
           AQ_self  = rowSums(AQ_scores[, self.index]),
           AQ_other = rowSums(AQ_scores[, other.index]),
           AQ_total = rowSums(AQ_scores[, total.index]),
           MI_self  = rowSums(MI_scores[, self.index]),
           MI_other = rowSums(MI_scores[, other.index]),
           MI_total = rowSums(MI_scores[, total.index]),
           NN_self  = rowSums(NN_scores[, self.index]),
           NN_other = rowSums(NN_scores[, other.index]),
           NN_total = rowSums(NN_scores[, total.index]),
           SG_self  = rowSums(SG_scores[, self.index]),
           SG_other = rowSums(SG_scores[, other.index]),
           SG_total = rowSums(SG_scores[, total.index]))
           
self = LEAS %>% select(ends_with("self"))
icc(self, model = "oneway", type = "consistency", unit = "average")

other = LEAS %>% select(ends_with("other"))
icc(other, model = "oneway", type = "consistency", unit = "average")

total = LEAS %>% select(ends_with("total"))
icc(total, model = "oneway", type = "consistency", unit = "average")

