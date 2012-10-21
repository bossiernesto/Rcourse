setwd("~/workspacehelios/RCourse/assigment2")#you should specify your own working directory

#point1

outcome<-read.csv("outcome-of-care-measures.csv",colClasses="character")

outcome[,11]=as.numeric(outcome[,11])
hist(outcome[,11], labels = TRUE,main='Heart attack 30-day Death Rate',
     xlab='30-day Death Rate')


#point 2
#1. Identify which columns of the data frame contain the 30-day death rate 
#from heart attack, heart failure,and pneumonia.
#column 11 heart attack
#column 18 heart failure
#column 23 pneumonia

#tuples <- function(x, n) do.call(expand.grid, rep(list(x), n))


xaxis="30-day Death Rate"

it=dataframe(cbind(11,"ss"),cbind(17,"ss"),cbind(23,"ddd"))
for(i in 1:nrow(it)) {
  row=it[i,]
  print(row)
}
