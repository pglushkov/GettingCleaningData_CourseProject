# The Book of Codes

On the methodology and processing steps of the original data - please see 'features_info.txt' from original
data for the task. In can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
In this file we will only give short description of final dataset - 'result.txt', created at Step 5 of the task.

1. 'result.txt' only contains AVERAGE values from original data. Averages were calculated over each 'Subject-Activity' pair for all features of interest.
2. We had 30 subjects and 6 activities in original dataset, thus we have 180 'measurements' in resulting dataset
3. Only 'mean' and 'std' features from original dataset were considered which makes only 86 features from original dataset present in the result
4. No fundamental change to original feature-naming convention was made, only slight 'cosmetic' changes to naming style was performed
5. 'Activity' and 'Subject' columns were added to the dataset just to make life a bit easier
6. 'Activity' label was replaced with an actual english word as was demanded in the task
7. One more time : this data set contains AVERAGE values from original dataset for each 'Subject-Acivity' pair!
8. To fulfil the wise and clever demands of the task, all features names were completely removed from the 'result.txt' by means of allmighty 'col.names=FALSE'. This clearly makes the life easier and the sky clearer and the sun brighter.
9. To get a glimpse of what feature-names used to be, their names are saved at 'final_features.txt' file. Frankly these are just numbered column-names as they were in final dataset, before we saved it with 'col.names=FALSE'.

To avoid redundant repetion of things that had allready been said and written, we wont rewrite or copy-paste any 
text from original 'feature_into.txt'. To understand what original data was - please read 'feature_into.txt' thoroughly,
it explains everything. To sum-up what resulting dataset is - just keep in mind that a subset of features was
selected (3) from original, mean values for those features were calculated(1), feature-names were slightly
tweaked(4). That is it, no magic tricks!