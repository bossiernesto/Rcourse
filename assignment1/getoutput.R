#Generate output

working_path="~/workspacehelios/RCourse/assignment1"

setwd(working_path)

#Assigment 1
source("http://spark-public.s3.amazonaws.com/compdata/scripts/getmonitor-test.R")
getmonitor.testscript()

#Assigment 2
source("http://spark-public.s3.amazonaws.com/compdata/scripts/complete-test.R")
complete.testscript()

#Assigment 3
source("http://spark-public.s3.amazonaws.com/compdata/scripts/corr-test.R")
corr.testscript()
