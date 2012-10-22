source("./utils.R",local=TRUE)

best <- function(state, outcome) {
  outcomes=getOutcomes()

  
  ## Read outcome data
  data=getData(state)
    
  #Prepare data  
  data=prepareData(data)
  
  data = data[data$State == state,]

  # clean up NA
  data=cleanNA(data)
  
  idx=getIdx(outcome)
  
  t_data <- data[!is.na(data[,idx]),]
  return(t_data[which.min(t_data[,idx]),2])
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}