getmonitor <- function(id,directory,summarize=FALSE){
  file_type<-".csv"
  # pad with zeros 
  padz <- function(x, n=max(nchar(x))) gsub(" ", "0", formatC(x, width=n)) 
  
  file_path=gsub(" ","",paste(directory,"/",padz(id,3),file_type,sep=""))#convert id from other format to string
  
  data<-read.csv(file_path)
  
  if (summarize)
    print (summary(data))    
  
  return(data)
  
}