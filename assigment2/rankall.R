source("./utils.R",local=TRUE)

rankall <- function(outcome,num = "best"){
  
  #build common functions
  outcome=tolower(outcome)
  outcomes=getOutcomes()
  
  ## Read outcome data
  data=getData(state)
  
  #Prepare data  
  data=prepareData(data)
  
  # outcome index and outcome data
  idx=getIdx(outcome)
  
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