# Excersice

## Part 1

Write a function named 'getmonitor' that takes three arguments: 'id', 'directory', and 'summarize'. Given a monitor ID number, 'getmonitor' reads that monitor's particulate matter data from the directory specified in the 'directory' argument and returns a data frame containing that monitor's data. If 'summarize = TRUE', then 'getmonitor' produces a summary of the data frame with the 'summary' function and prints it to the console. A prototype of the function is as follows

```r
getmonitor <- function(id, directory, summarize = FALSE) {
  ## 'id' is a vector of length 1 indicating the monitor ID
        ## number. The user can specify 'id' as either an integer, a
        ## character, or a numeric.
        
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'summarize' is a logical indicating whether a summary of
        ## the data should be printed to the console; the default is
        ## FALSE
}
```

### Solution

 I used simply an auxiliary function to do the left padding, whatever it's format is, if it's a numeric, string or vector of size 1

 ```r
padz <- function(x, n=max(nchar(x))) gsub(" ", "0", formatC(x, width=n)) 
```

After that i concatenate the directory name with the filename and type of file (in this case .csv), removing the whitespaces

```r
gsub(" ","",paste(directory,"/",padz(id,3),file_type,sep=""))
```
Finally i read the file and check if the summarize flag is set and print if it's true

## Part 2

Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. 
The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases. 
A prototype of this function follows

```r
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
}
```

### Solution

For this excercise it'll be only iterate over the id list and calculate the complete cases in with the nitrate and sulfate are not missing. 

```
df<-getmonitor(i,directory)
nobs<-nrow(subset(df,sulfate!="NA" & nitrate!="NA")) #this is strong-coupled on the data frame format of all the monitors
```

After that it should assign the quantity to the auxiliary data frame and return it

```
rbind(dataFrame,data.frame(id=i,nobs=nobs))->dataFrame
```

## Testing

testExcersice.r will hold all the unit tests that will use the functions for these excercises, for this it checks if the svUnit library ( for a quick reference of how to use it go to [SvUnitReference][1])



[1]: cran.r-project.org/web/packages/svUnit/vignettes/svUnit.pdf

