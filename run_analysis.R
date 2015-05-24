library(plyr)

get_file_info <- function(dir, type) {
        file_info = list(
                feature_codes = file.path(dir, 'features.txt'),
                activity_codes = file.path(dir, 'activity_labels.txt'),
                subject_info = file.path(dir, type, 
                                         paste('subject_', type, '.txt', sep='')),
                activity_info = file.path(dir, type, 
                                          paste('y_', type, '.txt', sep='')),
                features = file.path(dir, type, 
                                         paste('X_', type, '.txt', sep='')),
                inertia_dir = file.path(dir, type, 'Inertial Signals'),
                type = type
                )
        return(file_info)
        
}

get_feature_codes <- function(file){
        print('Reading feature codes')
        df = read.table(file, col.names = c('index', 'feature'))
}

get_activity_codes <- function(file){
        print('Reading activity codes')
        df = read.table(file, col.names = c('index', 'activity'))
}

get_desired_cols <- function(colnames) {
        mean_std_cols = grep('.*\\.mean\\.|\\.std\\..*', colnames)
        colnames = colnames[mean_std_cols]
}

read_data_set <- function(file_info, feature_codes, activity_codes){
        print('Reading feature info')      
        colnames = make.names(feature_codes$feature)
        records = read.table(file_info$features, 
                             col.names=feature_codes$feature)  
        desired_cols = get_desired_cols(colnames)
        records = subset(records, select=desired_cols)
        print('Reading subject information')        
        subject_info = factor(read.table(file_info$subject_info)$V1, levels=c(1:30))
        records$subject_id = subject_info
        print('Reading activity info')                
        activity_info = read.table(file_info$activity_info, col.names='index')
        activity_info = merge(activity_info, activity_codes, by='index')
        records$activity = activity_info$activity
        data_type = factor(rep(file_info$type, nrow(records)), 
                            levels = c("train", "test"))
        records$data_type = data_type
        return(records)
}

calculate_summary <- function(dt) {
        summary_avg = ddply(dt, c("subject_id", "activity"), numcolwise(mean))
        write.table(summary_avg, 'accelerometer_groupwise_avg.txt', row.name=FALSE)
}

analyze <- function(dir) {
        file_info = get_file_info(dir, 'train')
        activity_codes = get_activity_codes(file_info$activity_codes)
        feature_codes = get_feature_codes(file_info$feature_codes)
        print('Processing training data set')
        train_data_set = read_data_set(file_info, feature_codes, activity_codes)       
        file_info = get_file_info(dir, 'test')
        print('Processing test data set')        
        test_data_set = read_data_set(file_info, feature_codes, activity_codes)        
        data_set = rbind(train_data_set, test_data_set)
        write.table(data_set, 'accelerometer_mean_std.txt', row.name=FALSE)
        calculate_summary(data_set)
}

analyze(getwd())