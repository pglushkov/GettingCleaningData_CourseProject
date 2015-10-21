# Project description



## Neat intro

All code in current project is contained in one script 'run_analysis.R'. The script should be placed
next to directory with un-zipped data from the task. You can then run it in R, script does not take
any input parameters. All results, as demanded in the task description, will be placed in file
'result.txt' right next to the script. Have a nice day!

## Some basic description of the code

There's no rocket sciense in the script, it accomplishes the project task in a very straight-forward
manner, step-by-step. Although, there are some alterations to the task workflow, that author of the
code found reasonable:

* Step 2 is not performed on the dataset from Step 1. Instead we just find features of interest and memorize column indices to later extract them in final step
* Step 3 is not performed on the dataset from Step 1. We will perform this absolutely necessary and very important action on the final dataset. 
* Step 4 is also no performed on the dataset from Step 1. This another reasonable and sane action will be issued on the final dataset.

Aside from mentioned minor alterations, code works step-by-step according to the task. Comments are
placed along the lines in case some poor soul will have to read them. So there's no reason to write
code description twice, lets just leave it there.

## Some important details

### On extraction of the 'mean' and 'std' features.
Because no explicit instruction were given in the task of which features should be considered 'mean'
or 'std', a short path was chosen - we just take all features that have word 'mean' or word 'std'
in its naming, see function 'is_mean_or_std_feature()' in run_analysis.R for details.
### On giving 'discriptive' names to the features
Personally to me the whole thing is just a waste of time, cause naming notation in original dataset
makes absolutely fine sense. However, to do smth with the task, a further set of changes was applied
to each feature name:
* camelcase naming style was preserved cause its completely impossible to read someverylongfeaturename when its written with no separation of words
* starting 'f' and 't' were replaced with starting 'frequency' and 'time' correspondingly
* abbreviations like 'Acc' and 'Gyro' were replaced with full words
* all paranteses and '-' signes were removed
* 'mean()' and 'std()' are replaced with Mean and Std
See 'improve_the_name()' function in run_analysis.R for details.

## Data description 
As the task demanded, codebook with description of generated data is placed in separate file
'Codebook.md' that can be found right next to this README.

## Final words

I'd like to thank my parents, friends and co-workers for their persistent patiens and trust in me
while I've been struggling through the task dayly and nightly. I bring my sincere apoligies for
any typos and grammatic mistakes that take place in provided .md files.
