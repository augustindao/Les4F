# Origin: Programming Fall 2016 - Final Project
# Filename: PredictLigue1.R
# Author: Les 4 Fantastriques (Edgard, Victor, Zydney, Augustin)
# Creation date: 11 Nov. 2016 
# Last modified: 11 Nov. 2016

# Clear working space
rm(list=ls())

# Create dataframe
raw_data <- read.csv("~/Data/Ligue1-data.csv", header = TRUE, sep = ";")
data <- raw_data[1:20,c("ID","Team.Name","Standings.2015.16","Points.2015.16","Standings.2016.17","Points.2016.17","M1","M2","M3","M4","M5","M6","M7","M8","M9","M10")]

## 1. Define variables
n = 20
alpha_1 <- 0.7
alpha_2 <- 0.3
coeff_diff <- c(rep(0,20))

Points_toul_16 <- data[4,4]
Points_psg_16 <- data[3,4]

# We use working dataframe
output_data <- data[ ,c("ID","Team.Name","Points.2015.16","Points.2016.17")]

## 2. Assign a quality score to each team
data$Qual.Score <- score_team_qual(data$Points.2015.16, Points_psg_16, Points_toul_16)

## 3. Compute match difficulty coefficient

# Convert data into correct format for function use (don't really know why but otherwise it didn't work)
match_matrix <- as.matrix(data[1:20,7:16])
current_points <- as.matrix(data[1:20,6])

# Compute difficulty coefficient
diff_coeff <- match_diff_coeff(current_points, match_matrix)

# 4. Assign Current form score
data$Form[1:20] <- (coeff_diff*data$Points.2016.17 + data$Points.2016.17)

## 5. Assign point prediction
data$PointsPredicted <- round(alpha_1*output_data$Qual.Score + alpha_2*output_data$Form, digits = 0)

## 6. Plot league standing
output_data <- data[ ,c("ID","Team.Name","Points.2015.16","Points.2016.17","Qual.Score","Form","PointsPredicted")]
output_data <- output_data[order(output_data$PointsPredicted, decreasing = TRUE), ]
output_data
