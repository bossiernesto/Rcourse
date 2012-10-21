# defining a function 
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) 

if(!is.installed("digest"))
  install.packages("digest")

if(!is.installed("RCurl"))
  install.packages("RCurl")

source("http://spark-public.s3.amazonaws.com/compdata/scripts/submitscript.R")

#Uncomment this when the package works
#submit()

unzip('ProgAssigment2-data.zip')
