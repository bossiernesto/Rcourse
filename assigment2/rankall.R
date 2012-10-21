rankall <- function(outcome,num = "best"){
  
  #build common functions
  outcome=tolower(outcome)
  
  outcomes=c('heart attack','pneumonia','heart failure')
  
  #build dictionary for column name and outcome
  outcome_columns=c(11,23,17)
  names(outcome_columns)=outcomes
  
  #check if outcome is valid
  if (!outcome %in% outcomes){
    stop("invalid outcome")}
  
  data=read.csv("outcome-of-care-measures.csv",colClasses="character")
  
  for(i in outcome_columns){
  data[,i]=suppressWarnings(as.numeric(as.character(data[,i])))
  }
  data$State <- factor(data$State)
  # outcome index and outcome data
  idx=outcome_columns[outcome]
  
  data=data[!is.na(data[,idx]),c(2,7,idx)]
  names(data)=c("hospital","state","rate")
  
  # 
  rank_val=tapply(data[,"rate"],data$state,FUN=function(x,num) {
    
    if (num == "best") {
      #print(which.min(x))
      return (x[which.min(x)])
      
    }else if (num == "worst") {
      
      #print(which.max(x))
      return (x[which.max(x)])
      
    }else {
      
      rank = as.integer(num)
      
      if(is.na(rank) || rank > length(x)) {
        return (NA)
      }
      
      idx = order(x)[rank]
      return (x[idx])
    }},num)
  

  states=names(rank_val)
  ret=data.frame()
  
  for (i in 1:length(states)) 
  {
    st=states[i]
    rate=rank_val[[i]]
    
    if (num == "best" || num == "worst") {
      ret=rbind(ret, data[data$state == st & data$rate == rate,])
      
    }else{
      
      if(!is.na(rate)){
        
        tmp=data[data$state==st & data$rate <= rate,]
        ret=rbind(ret, tmp[order(tmp$rate,tmp$hospital),])
      }
    }
    
  } 
       
  return(ret[,c(1,2)])
  
}