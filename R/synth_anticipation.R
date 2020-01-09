rm(list=ls())

#Library
#install.packages("readstata13")
#library("Synth")
library(readstata13)

#Set working directory
setwd("C:/Users/adeli/student-project-agaramow/SCM/Final_Data")

#Data
df <- read.csv('AllDataUK.csv')

#Synth
# NOTE: check why unit.names.variable is not working
# missing data unit 10

# Preparing data 
#df <- as.data.frame(df)
dataprep.out <- dataprep(foo = df,
                              predictors = c("growth", "GDPPCcons", "rightwing", "uk_mom", "epl", "capital_quinn", "TopIncomeTaxRate", "stock_price", "SM_cap_2panel"),
                              predictors.op = "mean",
                              time.predictors.prior = 1971:1982,
                              special.predictors = list(
                                  list("Top1", c(1971, 1976, 1979), "mean")),
                              dependent = "Top1P",
                              unit.variable = "ccode",
                              #unit.names.variable = "Country",
                              time.variable = "year",
                              treatment.identifier = 17,
                              controls.identifier = c(1,2,3,4,5,6,7,8,9,11,15,16),
                              time.optimize.ssr = 1971:1982,
                              time.plot = 1971:1979)

# Finding optimal weights
synth.out <- synth(data.prep.obj = dataprep.out, method = "BFGS")

# Calculating gaps
gaps <- dataprep.out$Y1plot - (dataprep.out$Y0plot %*% synth.out$solution.w)

# Produce tables with table functions
synth.tables <- synth.tab(dataprep.res = dataprep.out, synth.res = synth.out)
names(synth.tables)


# Table: optimal weights 
synth.tables$tab.w[c(1,2,3,4,5,6,7,8,9,11,15,16), ]

# Table: similarities: comparing mean of pre treatment period?
synth.tables$tab.pred[1:10, ]

# Table 2: gaps + plot gaps
gaps[1:15, 1]

# Plot gaps
# include vertical line for tretament year and when agreement was made in 1983
gaps.plot(synth.res = synth.out, dataprep.res = dataprep.out,
          Ylab = "Gap in top 1 income shares)", Xlab = "year",
          Ylim = c(-1.5, 1.5), Main = NA)

# Graph: show both UK and SCG
# include vertical line for tretament year and when agreement was made in 1983
path.plot(synth.res = synth.out, dataprep.res = dataprep.out, Ylab = "Top 1 income shares",
          Xlab = "year",
          Ylim = c(0, 12), Legend = c("UK",  "SCG"), Legend.position = "bottomright")





############################################
#### CODE FROM AUTHORS AS COMPARISON #######
############################################
#* Necessary adjustments of dataset (deleting countries without data)
#if `Top'==Top10P drop if  ccode == 4
#if `Top'==Top5P drop if  ccode == 7
#if `Top'==Top01P drop if  ccode == 4 | ccode ==11

#** drop missing relations variables
#if `Top'==Top10_01 drop if  ccode == 4
#if `Top'==Top10_5 drop if  ccode == 4 | ccode == 7
#if `Top'==Top10_1 drop if  ccode == 4
#if `Top'==Top5_1 drop if  ccode == 7
#if `Top'==Top5_01 drop if  ccode == 4 | ccode == 7
#if `Top'==Top1_01 drop if  ccode == 4


#*** Synth Thtcher era 

#synth `Top' `variables' `Top'(1979) `Top'(1982) `Top'(1984) `Top'(1986) ///
#, trunit(17) trperiod(`trperiod') ///
#  xperiod(1979(1)`trperiod') mspeperiod(1979(1)`trperiod') resultsperiod(1979(1)1997) ///
#nested allopt fig keep(Data\Output\UKsynth_`Top'80s) replace
#graph export Data\Output\`Top'UK80s.png, as(png) replace

