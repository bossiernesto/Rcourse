best <- function(state, outcome) {
  outcome=tolower(outcome)
  
  outcomes=c('heart attack','heart disease','pneumonia')
  
  #build dictionary for column name and outcome
  outcome_columns=c(11,17,18)
  names(outcome_columns)=outcomes
  
  #check if outcome is valid
  if (!outcome %in% outcomes){
    stop("invalid outcome")}
  
  ## Read outcome data
  setwd("~/workspacehelios/RCourse/assigment2")#you should specify your own working directory
  data=read.csv("outcome-of-care-measures.csv",colClasses="character")  
  ## Check that state and outcome are valid
  str_states <- data$State
  if (!state %in% str_states){
    stop("Invalid state")
  }
  
  #Prepare data  
  data[,11] <- suppressWarnings(as.numeric(data[,11]))
  data[,17] <- suppressWarnings(as.numeric(data[,17]))
  data[,23] <- suppressWarnings(as.numeric(data[,23]))
  data$State <- factor(data$State)
  
  data = data[data$State == state,]

  # clean up NA
  cc =complete.cases(data)
  data = data[cc,]
  
  idx=outcome_columns[outcome]
  
  t_data <- data[!is.na(data[,idx]),]
  return(t_data[which.min(t_data[,idx]),2])
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}