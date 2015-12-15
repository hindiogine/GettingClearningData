library(dplyr)
library(jpeg)

rm(list = ls())
setwd("~/Code/GettingCleaningData")

url.1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url.1, destfile = "GDP.csv", method = "curl")
gdp.df <- read.csv(file = "GDP.csv", skip = 4, blank.lines.skip = TRUE, stringsAsFactors = FALSE)
gdp.df <- gdp.df[c(1:190, 192:215, 217, 219:231), ]
gdp.df$X.1 <- as.numeric(gdp.df$X.1)

url.2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url.2, destfile = "educ.csv", method = "curl")
educ.df <- read.csv(file = "educ.csv", stringsAsFactors = FALSE)

# temp <- merge(gdp.df, educ.df, by.x = "CountryCode", by.y = "X1", all=TRUE)

temp <- left_join(educ.df, gdp.df, by = c("CountryCode" = "X"))
temp.2 <- arrange(temp, desc(X.1))

temp.3 <- filter(temp, Income.Group == "High income: OECD")
temp.4 <- filter(temp, Income.Group == "High income: nonOECD")

mean(temp.3$X.1, na.rm = TRUE)
mean(temp.4$X.1, na.rm = TRUE)

quantile(temp.2$X.1, na.rm=TRUE)