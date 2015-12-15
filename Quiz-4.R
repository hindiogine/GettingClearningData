setwd("~/Code/GettingCleaningData")
library(dplyr)
library(quantmod)
library(lubridate)

rm(list = ls())

my_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = my_url, destfile = "acs.csv", method = "curl")
acs <- read.csv(file = "acs.csv")
my_names <- tolower(names(acs))

my_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
download.file(url = my_url, destfile = "gdp.csv", method = "curl")
read.csv(file = "gdp.csv", skip = 4, nrows = 190) -> gdp

test <- as.numeric(gsub(",","", gdp$X.4))

mean(test, na.rm = TRUE) -> temp

print(temp)

gdp_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
educ_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url = gdp_url, destfile = "gdp.csv", method = "curl")
download.file(url = educ_url, destfile = "educ.csv", method = "curl")

gdp.df  <- read.csv(file = "gdp.csv", skip = 4, nrows = 190, stringsAsFactors = FALSE)
educ.df <- read.csv(file = "educ.csv", stringsAsFactors = FALSE)

temp <- left_join(educ.df, gdp.df, by = c("CountryCode" = "X"))

filter(temp, grepl("^Fiscal year end: June", Special.Notes)) -> temp.2
print(temp.2$Special.Notes)

print(dim(temp.2)[1])


amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn)
temp.1 <- sampleTimes[year(sampleTimes) == 2012 ]
temp.2 <- sampleTimes[year(sampleTimes) == 2012 & weekdays(sampleTimes) == "Monday" ]
print(length(temp.1))
print(length(temp.2))

