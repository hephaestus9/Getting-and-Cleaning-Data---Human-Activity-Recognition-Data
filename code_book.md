As is the script will only generate one dataframe.

>**mean_data**

However, if line #82 is commented out, then the script will generate the following dataframes:

>**org_compiled_data**

>**data**

>**my_data**

>**mean_data**

'org_compiled_data' is the original data from the repository, but has the test and training data together as one table

'data' is the same as 'org_compiled_data', with the exception of the 'activities' field.  In the 'data' dataframe the activities 
are descriptive rather than integers.

'my_data' is derived from the 'data' dataframe, it contains columns with "-mean" or "-std" in the title, and the "activities" and "subject"
columns

'mean_data' is the mean of the value for each column per activity per subject

The script will also generate a file called "mean_data.df" which is a copy of the 'mean_data' dataframe, however the float values are shortened.

For an explination of the columns see either the readme.md or the 'features_info.txt' files.

