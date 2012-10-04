source("./getmonitor.r")
source("./complete.r")
# defining a function 
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) 

#If you dont have svUnit
if (!is.installed("svUnit"))
  install.packages("svUnit")

library(svUnit)

#you should change this for your specdata folder with the data frames
dir<-"/home/ernesto/Dropbox/cousera/Rcourse/specdata"

test(GetMonitor) <- function(){
  a<-getmonitor(1,dir,TRUE)
  checkEqualsNumeric(1461,nrow(a))
  checkEqualsNumeric(4,ncol(a))
}

clearLog()
runTest(GetMonitor)

test(Complete)<-function(){
  nobs<-c(1041,474,192,148,96)
  a<-complete(dir,c(2,4,8,10,12))[2]
  checkEquals(a,nobs)
}
