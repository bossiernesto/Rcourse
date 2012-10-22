getOutcomes <- function(){
  outcomes=c('heart attack','heart disease','pneumonia')
  
  #build dictionary for column name and outcome
  outcome_columns=c(11,17,23)
  names(outcome_columns)=outcomes
  return(outcome_columns)
}

getIdx <- function(outcome){
  outcomes=getOutcomes()
  
  #check if outcome is valid
  if (!outcome %in% names(outcomes)){
    stop("invalid outcome")}
  
  idx=outcomes[outcome]
  return(idx)
}

getData <- function(state){
  ## Read outcome data
  ##you should specify your own working directory
  data=read.csv("outcome-of-care-measures.csv",colClasses="character")  
  ## Check that state and outcome are valid
  str_states <- data$State
  if (!state %in% str_states){
    stop("Invalid state")
  }
  return(data)
}

prepareData <- function(data){
  #Prepare data  
  data[,11] <- suppressWarnings(as.numeric(as.character(data[,11])))
  data[,17] <- suppressWarnings(as.numeric(as.character(data[,17])))
  data[,23] <- suppressWarnings(as.numeric(as.character(data[,23])))
  data$State <- factor(data$State)
  return(data)
}

cleanNA <- function(data){
  # clean up NA
  cc = complete.cases(data)
  data = data[cc,]
  return(data)
}

## If you want to source() a bunch of files, something like
## the following may be useful:
sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}