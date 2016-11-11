# Origin: Programming Fall 2016 - Final Project
# Filename: PredictLigue1.R
# Author: Les 4 Fantastriques
# Creation date: 11 Nov. 2016 
# Last modified: 11 Nov. 2016

# Clear working space
rm(list=ls())

# Create dataframe
raw_data <- read.csv("/Users/augustin/Documents/Programming/Les4F - FinalProject/Data/Ligue1-data.csv", header = TRUE, sep = ";")
data <- raw_data[1:20,c("X","X.1","Standings.2015.16","Points.2015.16","Standings.2016.17","Points.2016.17","M1","M2","M3","M4","M5","M6","M7","M8","M9","M10")]

## Define variables
n = 20
alpha_1 <- 0.7
alpha_2 <- 0.3

P_toul_16 <- data[4,4]
P_psg_16 <- data[3,4]

max_diff <- c(rep(0,20))
diff_curr <- c(rep(0,20))
diff_futur <- c(rep(0,20))
coeff_diff <- c(rep(0,20))

## 1. Fill team quality score
data$Qual[1:20] <- (1-((P_psg_16 - data$Points.2015.16[1:20])/P_psg_16))*P_toul_16


## 2. Fill current form score

#maximum difficulty of matches
max_diff[1:20] <- 187 - (20 - data$Standings.2016.17[1:20])

#current form given match played
for(i in 1:20){
  diff_curr[i] <- sum(20 - as.numeric(data[i,7:16])/2)
}

#difficulty of future matches
diff_futur <- max_diff - diff_curr

#difficulty coefficient
coeff_diff <- (diff_futur/diff_curr)

# Current form score
data$Form[1:20] <- (coeff_diff*data$Points.2016.17 + data$Points.2016.17)

## 3. Assign point prediction
data$PointsPredicted <- round(alpha_1*data$Qual + alpha_2*data$Form, digits = 0)

## 4. Plot league standing
output_data <- data[ ,c("X.1","Points.2015.16","Points.2016.17","PointsPredicted")]
output_data <- output_data[order(PointsPredicted, decreasing = TRUE), ]
output_data

# Grouped Bar Plot
#library(ggplot2)
#ggplot(output_data[1:5,], aes(x = X.1, y = PointsPredicted,)) + geom_bar(stat="identity", width=0.5)
