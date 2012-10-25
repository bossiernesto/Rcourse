source("./utils.R",local=TRUE)

rankhospital <- function(state,outcome,num = "best"){
  
  outcomes=getOutcomes()
  #build common functions
  idx=getIdx(outcome)
  
  ## Read outcome data
  #setwd("~/workspacehelios/RCourse/assigment2")#you should specify your own working directory
  data = getData(state)
  #Prepare data  
  data=prepareData(data)
  # clean up NA
  data=cleanNA(data)
  
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
  
  t_data = t_data[with(t_data,order(t_data[,idx],t_data[,2])),]
  rank = checkRank(num,t_data[,idx])
  
  #print(rank)
  
  if(is.integer(rank))
    return( t_data[rank,2])
  else
    return(rank)
  
}