#Readme.md

## Description
The run_analysis.R downloads data from a specified source and performs analysis on the data to clean up the data
and create a Tidy Data set.

## Analysis
* Step 1:  the appropriate libraries are loaded. 
* Step 2: Then it checks if the "data" folder exists in the working directory, if not one is created
* Step 3: If the data is not downloaded from the source, it is downloaded
* Step 4: If the data is not unziped then the data is unzipped. 
* Step 5: Appropriate files are read from the unzipped folder.
* Step 6: Columns are appropriately named for the files downloaded
* Step 7: Since the data is divided into two sets (test and training) it is combined appropriately to create subject , labelData, TotalData Data frames
* Step 8: The TotalData DF is subsetted to only have columns that have the word mean() or std()
* Step 9: On resulting DF (TotalData), analysis is performed to clean up the column names to remove special characters and lower case all names, as well as subsitute the work time for t and freq for f
* Step 10: Merging Activity names to TotalData to get descriptive activity names
* Step 11: TidyData set is created by grouping the Totaldata by subject and activty and each ungrouped column is summarized by averaging.
* Step 12: Output file is created with the name tidyData.txt
* Step 13: Environment variables are cleared

The dimensions for the tidyData set is 180 X 68

