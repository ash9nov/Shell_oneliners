#important R commands:

#overlapping two data frames  based on common columns overlapping entries:
 rslt<- DF1[which(DF1$common_col %in% DF2$common_col), ]

#selecting unique rows in a data.frame
 exon_uniq<-exon_start[!duplicated(exon_start),]

#sorting a data.frame on basis of columns
 exon_uniq_sorted<-exon_uniq[order(exon_uniq[,1], exon_uniq[,2]),]

######################
#Join in R
#Inner join	
merge(df1, df2, by='common_key_column')
#Outer join	
merge(df1, df2, by='common_key_column', all=TRUE)
#Left outer	
merge(df1, df2, by='common_key_column', all.x=TRUE)
#Right outer	
merge(df1, df2, by='common_key_column', all.y=TRUE)
######################

#merging two columns in a data.frame with specific seperator
within(DF, new_Col_name <- paste(col1, col2, sep='_'))

#conditional search
 View(DF[DF$row_name=="value",])
# if there are multiple conditions
View(DF[DF$row_name=="value" | DF$row_name=="value" | DF$row_name=="value" |,])

#Renaming a column in a data frame
  # df = dataframe
  # old.var.name = The name you don't like anymore
  # new.var.name = The name you want to get
 names(df)[names(df) == 'old.var.name'] <- 'new.var.name'
 
#adding a column in a data.farme
my.dataframe["MY_NEW_COLUMN"] <- NA
 
 
 
 
 
 