getmonitor <- function(id,directory,summarize=FALSE){
  ## 'id' is a vector of length 1 indicating the monitor ID
  ## number. The user can specify 'id' as either an integer, a
  ## character, or a numeric.
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'summarize' is a logical indicating whether a summary of
  ## the data should be printed to the console; the default is
  ## FALSE
  file_type<-".csv"
  # pad with zeros 
  padz <- function(x, n=max(nchar(x))) gsub(" ", "0", formatC(x, width=n)) 
  
  file_path=gsub(" ","",paste(directory,"/",padz(id,3),file_type,sep=""))#convert id from other format to string
  
  data<-read.csv(file_path)
  
  if (summarize)
    print (summary(data))    
  
  return(data)
  
}