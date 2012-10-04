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

```r
df<-getmonitor(i,directory)
nobs<-nrow(subset(df,sulfate!="NA" & nitrate!="NA")) #this is strong-coupled on the data frame format of all the monitors
```

After that it should assign the quantity to the auxiliary data frame and return it

```r
rbind(dataFrame,data.frame(id=i,nobs=nobs))->dataFrame
```

#Part 3
Write a function that takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. A prototype of this function follows

```r
corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
```

##solution

For this case, we'll reuse the complete funtion to the comparison with the threshold, if it applies to it the correlation of the dataframe will be run for the data frame and the result will be saved in the vector
```r
monitorsToCorr<-subset(complete(directory,1:numberOfFiles),nobs>threshold)[1][,1]#get all the monitors to correlate  
```
After getting our vector of monitors to get, we'll need to format the data frame, as we need to filter the complete cases and remove the unwanted columns, i accomplish this by using an anonymous function called formatMonitor

```r
formatMonitor <-function(i,directory) subset(getmonitor(i,directory),sulfate!="NA" & nitrate!="NA",select=c(sulfate,nitrate))
```
Now we can use this to iterate over our monitorsToCorr vector and apply the correlation to them

TODO: i should be doing this with an lapply function, but ill refactor the code later on

## Testing

testExcersice.r will hold all the unit tests that will use the functions for these excercises, for this it checks if the svUnit library ( for a quick reference of how to use it go to [SvUnitReference][1])



[1]: cran.r-project.org/web/packages/svUnit/vignettes/svUnit.pdf

