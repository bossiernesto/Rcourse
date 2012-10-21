rankhospital <- function(state,outcome,num = "best"){
  
  #build common functions
  outcome=tolower(outcome)
  
  outcomes=c('heart attack','heart disease','pneumonia')
  
  #build dictionary for column name and outcome
  outcome_columns=c(11,17,23)
  names(outcome_columns)=outcomes
  
  if (!outcome %in% outcomes){
    stop("invalid outcome")
    }
  ## Read outcome data
  setwd("~/workspacehelios/RCourse/assigment2")#you should specify your own working directory
  data = read.csv("outcome-of-care-measures.csv",colClasses="character")
  str_states <- data$State
  if (!state %in% str_states)  stop("Invalid state") 
  
  #Prepare data  
  data[,11] <- suppressWarnings(as.numeric(as.character(data[,11])))
  data[,17] <- suppressWarnings(as.numeric(as.character(data[,17])))
  data[,23] <- suppressWarnings(as.numeric(as.character(data[,23])))
  data$State <- factor(data$State)

  # clean up NA
  cc = complete.cases(data)
  data = data[cc,]
  
  # data for the state
  t_data = data[data$State == state,]
  
  #
  checkRank <- function(num,data) {
    
    max = which.max(data)
    if (num == "best") {
      return(which.min(data))
    }else if (num == 'worst'){
      return(max)
    }
    
    rank = as.integer(num)
    
    if (rank > max)
      return(NA)
    return(rank)
  }
  
  idx=outcome_columns[outcome]
  
  t_data = t_data[with(t_data,order(t_data[,idx],t_data[,2])),]
  rank = checkRank(num,t_data[,idx])
  
  #print(rank)
  
  if(is.integer(rank))
    return( t_data[rank,2])
  else
    return(rank)
  
}