complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  dataFrame<-NULL
  for(i in id){
    df<-getmonitor(i,directory)
    nobs<-nrow(subset(df,sulfate!="NA" & nitrate!="NA"))  #this is strong-coupled on the data frame format of all the monitors
    rbind(dataFrame,data.frame(id=i,nobs=nobs))->dataFrame
  }
    
  return(dataFrame)
}