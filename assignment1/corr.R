corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  numberOfFiles<-length(list.files(directory))
  vec<-c()
  
  monitorsToCorr<-subset(complete(directory,1:numberOfFiles),nobs>threshold)[1][,1]#get all the monitors to correlate  
  #formatMonitor Anon fx, will subselect the getmonitor function to aply the correlation
  formatMonitor <-function(i,directory) subset(getmonitor(i,directory),sulfate!="NA" & nitrate!="NA",select=c(sulfate,nitrate))
  
  for(i in monitorsToCorr){
      monitor<-formatMonitor(i,directory)
      vec<-c(vec,cor(monitor)[2])
  }

  return(vec)
}