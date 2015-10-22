run_analysis <- function() {
	# main entry point for the code that performs analysis of the data

	############ KINDA PERFORMING STEP 1 FROM THE TASK ....
	# ... reading data ... 
	cols_map = read.table('./UCI HAR Dataset/features.txt');
	data_train = read.table('./UCI HAR Dataset/train/X_train.txt');
	data_test = read.table('./UCI HAR Dataset/test/X_test.txt');
	subj_train = read.table('./UCI HAR Dataset/train/subject_train.txt');
	subj_test = read.table('./UCI HAR Dataset/test/subject_test.txt');
	act_train = read.table('./UCI HAR Dataset/train/y_train.txt');
	act_test = read.table('./UCI HAR Dataset/test/y_test.txt');

	# ... re-arranging data ...
	data_full = rbind(data_train, data_test);
	subj_full = rbind(subj_train, subj_test);
	act_full = rbind(act_train, act_test);
	colnames(data_full) <- cols_map[,2];
	colnames(subj_full) <- "Subject";
	colnames(act_full) <- "Activity";
	data_full = cbind(data_full, subj_full);
	data_full = cbind(data_full, act_full);
	
	### 'data_full' now contains all merged data with attached 'Activity' and 'Subject' columns
	print("Merged train and test data into one massive uber-set ...");


	############ KINDA PERFORMING STEP 2 FROM THE TASK ...
	n = 1;
	f_idxs = vector();
	for ( FeatureName in cols_map[,2] ) {
		if (is_mean_or_std_feature(FeatureName)) {
			f_idxs <- c(f_idxs, n);
		}
		n = n + 1;
	}
	f_idxs <- c(f_idxs, ncol(data_full) - 1);
	f_idxs <- c(f_idxs, ncol(data_full));

	### We did not actually 'extracted only columns that bla-bla-bla' as written in the task, instead we
	### 'memorized' indices of those columns for later use. 'f_idxs' now contains indexes of all columns
	### that describe all 'mean' and 'std' features ...
	print("Extracted all mean and std features ...");


	############ KINDA SKIPPING STEP 3 AND STEP 4 FROM THE TASK ...	
	### For now we just skip Step 3 and 4, cause whats the point in renaming columns and replacin cells now, 
	### lets do all of that afterwards when final tidy dataset is formed and we're about to save it on disk!
	print("Leaving best for last, will rename and decode sfuff later ...");

	############ KINDA PERFORMING MAIN PART OF STEP 5 FROM THE TASK ...

	# pre-allocating final tidy dataset
	out_parts = data.frame(); 

	# splitting our 'full_data' from Step 1 by 'Subject' criteria
	subj_parts = split(data_full, data_full$Subject);

	# traversing through all subjects ....
	for (subj in subj_parts) {

		# splitting current 'subj' by 'Activity' criteria
		act_parts = split(subj, subj$Activity);

		# traversing through all activities in current subject
		for (act in act_parts) {

			final_act = act[, f_idxs];
			# now we finally have a dataframe for m'th user n'th activity with only relevant features in it
			# calculate average values for each feature

			# dbg
			#print(sprintf("PROCESSING ACTIVITY %d FOR SUBJECT %d ...\n", final_act$Activity[1], final_act$Subject[1])); 

			# pre-allocating vector for final average values of each feature of interes ...
			AVGS = vector(mode="numeric", length = ncol(final_act));

			# calculating actual average values for each feature of interest
			for (k in 1:ncol(final_act)) {
				AVGS[k] = mean(final_act[,k]);
			}

			# adding average result to our final tidy dataset
			out_parts <- rbind(out_parts, AVGS);
		}
	}

	names(out_parts) <- names(data_full)[f_idxs];
	### Now, our 'out_parts' is a dataset that contains all needed features, averaged across
	### 'Subject/Activity' pairs ... If we now "could just go ahead and ..." finalize the result
	print("Final dataset is formed...");


	############ KINDA PERFORMING STEP 4 FROM THE TASK ...	
	# Now is the most hidious, stupid, useless and obscure part of the whole task. I trully believe that provided
	# feature-naming notation in given dataset is clear and explicit and does not need any changes what-so-ever.
	# But, as the task demands, lets make those perfectly fine features names even more 'clear' and 'readable'
	# and 'descriptive'!
	
	new_names = names(out_parts);
	new_names = lapply(new_names, improve_the_name);
	names(out_parts)<-new_names;
	### now we have sooooooo much better namings of features, in makes me wanna jump on my chair!
	print("Feature names are changed in final dataset ...");

	############ KINDA PERFORMING STEP 3 FROM THE TASK ...	
	# just replacing activity code with an actual english word for it ...
	for (k in 1:nrow(out_parts)) {
		out_parts$Activity[k] = decode_actividy(out_parts$Activity[k]);
	}
	### activity codes are replaced with actual words
	print("Activity codes are decoded in final dataset ...");


	# dbg ...
	#head(out_parts, 2);

	############ KINDA FINALIZING STEP 5 FROM THE TASK ...
	# wrtie our result to a file
	write.table(out_parts, file = "result.txt", col.names = FALSE);

	# creating feature-names dataframe for our result to save it for future generations...
	result_feature_names = data.frame(1:length(new_names), unlist(new_names));
	write.table(result_feature_names, file = "final_features.txt", col.names = FALSE, row.names = FALSE);

	### now everyone is happy and justice and peace are restored in Universe
	print("All done, see results.txt for results ...");
}


# Attempt to automate search for features, that represent 'mean' and 'std'
# characteristics of corresponding features ... Function returns 'true' if
# if finds that input name has anything to do with 'mean' or 'std' terms
is_mean_or_std_feature <- function(feature = "") {
	r1 = length(grep("mean", tolower(feature)));
	r2 = length(grep("std", tolower(feature)));
	return ( r1 || r2);
}




# This is just one of countless ways of how to 'improve' the namings of our features.
# The thing is purely subjective and if you find this implementation a poor choice,
# please feel free to issue a legal action to European Court of Human Rights. Thankz!
improve_the_name <- function(old_name) {

	#dbg
	#print(sprintf("Working on name = %s ...", old_name));

	new_name = old_name;
	# replacing starting 'f' by word 'frequency' if any
	if (substr(old_name, 1, 1) == 'f') {
		new_name = paste('frequency', substr(old_name, 2, nchar(old_name)), sep='');
	}
	# replacing starting 't' by word 'time' if any
	if (substr(old_name, 1, 1) == 't') {
		new_name = paste('time', substr(old_name, 2, nchar(old_name)), sep='');
	}
	new_name = sub("Acc","Accelerometer", new_name);
	new_name = sub("Mag","Magnitude", new_name);
	new_name = sub("Gyro","Gyroscope", new_name);
	new_name = sub("-meanFreq\\(\\)", "MeanFrequency", new_name);
	new_name = sub("-mean\\(\\)","Mean", new_name);
	new_name = sub("-std\\(\\)","Std", new_name);
	new_name = sub("-Z","Z", new_name);
	new_name = sub("-Y","Y", new_name);
	new_name = sub("-X","X", new_name);

	#dbg
	#print(sprintf("Some results = %s ...", new_name));
	return(new_name);
}

# This is basically a 'decode-the-number' kind of function, it simply maps input
# number to corresponding word in English. Words for codes are taken from file 
# 'activity_labels.txt' from original dataset.
decode_actividy <- function(acode) {
	if (acode == 1) {
		return("WALKING");
	}
	if (acode == 2) {
		return("WALKING_UPSTAIRS");
	}
	if (acode == 3) {
		return("WALKING_DOWNSTAIRS");
	}
	if (acode == 4) {
		return("SITTING");
	}	
	if (acode == 5) {
		return("STANDING");
	}
	if (acode == 6) {
		return("LAYING");
	}
	warning('INVALUD INPUT TO decode_activity() ...');
	return("NA");
}


