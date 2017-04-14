#load readr
library(readr)

#Import csv file to data frame
titan_df <- read_csv("~/Foundations_Exercises/titanic3_original.csv")

#Find missing values in the 'embarked' column and replace with S - missing values 
#could be a blank, or an empty string

titan_df$embarked[is.na(titan_df$embarked)] <- "S"

#Calculate mean of age column and replace missing values

titan_df$age[is.na(titan_df$age)] <- mean(titan_df$age, na.rm = TRUE)
  
#Find missing values in lifeboat column. Fill with dummy value such as NA
titan_df$boat[is.na(titan_df$boat)] <- "None"

#Create new column has_cabin_number and make it '1' if there was, '0' if there wasn't
titan_df$has_cabin_number <- NA
titan_df$has_cabin_number[is.na(titan_df$cabin)] <- "0"
titan_df$has_cabin_number[!is.na(titan_df$cabin)] <- "1"

#save changes to new file, 'titanic_clean.csv'
titanic_clean <- titan_df
write.table(titanic_clean, "~/Foundations_Exercises/titanic_clean.csv", row.names = FALSE, sep = ",")
