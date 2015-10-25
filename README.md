This readme provides information about the files in the 'gettingcleaning-repo'

1. Codebok - This contains information about the raw data and the columns in the processed output data data.
2. run_analysis.R - This contains the R script used to convert the raw data into processed tidy data set. The comments describing the action of the various steps is incuded here.



The logic used to generate the tidy data set from the raw dataset is as below.

1. Combine the Train and Test datasets for X, y and subject into a sigle set of X,y and subject data sets. Apply the column names to X,y and subject data here.After this step each data set has 10299 rows. Further X has 561 columns.
2. Merge the X,y and subject datasets obtained in previous step into a single super dataset cointaining all details.The resulting dataset has 10299 rows and 563 columns.
3. From the merged data set filter only the columns containing 'mean' or 'std' to create a narrow dataset (MeanFreq is not considered).The resulting data set has 69 columns and 10299 rows.
4. Apply the Activity names in place of the activity id in the narrow data set to make it more readable.
5. Summarize the dataset obtained in previous step to compute the mean of the columns for each Subecjid and Activity name. The resulting data contains 180 rows and 69 columns.

