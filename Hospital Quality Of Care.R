# Project: Ranking System for Hospital Quality and Clinical Outcomes in R.
# Author: [Ahmed Bestawy]
# Data Source: [https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip]

# Description : ----
# This project gives you a strong set of R functions that can look at and rank 
# more than 4,000 U.S. hospitals based on their 30-day mortality rates for three
# specific clinical outcomes: heart attack, heart failure, and pneumonia.
# The script takes raw Medicare data and finds the best hospitals at the state
# and national levels and cleans up messy data on its own and has a built-in 
# referee to break ties if two hospitals have the exact same mortality rate.


# Downloading data. ----
data_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
if(!file.exists("outcome-of-care-measures.csv"))
          {download.file(data_url,"data.zip")
          unzip("data.zip")}



# Reading raw data. 
outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcomedata) 

names(outcomedata)
outcomedata[ ,11] <- as.numeric(outcome[ ,11])

hist(outcomedata[ ,11])


# Cleaning the data.----

analysis_data <- data.frame(outcomedata[ ,c(2,7,11,17,23)])

colnames(analysis_data) <- c("Hospital", "state","heart attack",
                             "heart failure","pneumonia")

analysis_data[ ,1:2] <- lapply(analysis_data[ ,1:2], as.character)

analysis_data[ ,3:5] <- lapply(analysis_data[ ,3:5], as.numeric)

ss <- split(analysis_data, analysis_data$state)


# Finding the best hospital in a state. ----

best <- function(state, outcome) {
    if(!state %in% names(ss)) { 
        stop("invalid state")
    } 
    else if(!outcome %in% names(analysis_data)){
        stop("invalid outcome")
    }
    state_data <- ss[[state]]
    state_data <- state_data[order(state_data[ , outcome]
                                   , state_data[ ,1]), ]

    state_data[1,1]
}


# Ranking hospitals by outcome in a state ----

rankhospital <- function(state, outcome, num = "best") {
    if(!state %in% names(ss)) { 
        stop("invalid state")
    } 
    else if(!outcome %in% names(analysis_data)){
        stop("invalid outcome")
    }
    state_data <- ss[[state]]
    state_data <- state_data[order(state_data[ , outcome]
                                   , state_data[ ,1]), ]
    
    RL <- state_data[!is.na(state_data[ , outcome]), ]
    if(num == "best"){
        num <- 1
    } else if(num == "worst") {
        num <- nrow(RL)
    }
    RL[num,1]
}


# Ranking hospitals across all states ----

rankall <- function(outcome, num = "best") {
    n <- names(ss)
    if(!outcome %in% names(analysis_data)){
        stop("invalid outcome")
    }
    hosp_vector <- sapply(n, rankhospital, outcome, num)
    final_output <- data.frame(hospital = hosp_vector,
                               state = names(hosp_vector))
    final_output
}



