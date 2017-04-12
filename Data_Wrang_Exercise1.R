#Data Wrangling Exercise 1

#get plyr
library(plyr)

#get dplyr
library(dplyr)

#get tidyr
library(tidyr)

#get readr
library(readr)

#Import csv file to data frame
refine_original <- read_csv("~/Foundations_Exercises/refine_original.csv")

#Use tolower() to convert company names to lower case
refine_original$company <- tolower(refine_original$company)

#Then substitute correctly spelled names - there must be a better way to do this with lapply or a for loop?
refine_original$company <- gsub(pattern = "^a.*", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "^u.*", replacement = "unilever", x = refine_original$company)
refine_original$company <- gsub(pattern = "^p.*", replacement = "philips", x = refine_original$company)
refine_original$company <- gsub(pattern = "^f.*", replacement = "philips", x = refine_original$company)

#Rename 'product code / number' column to 'product' 
#Using base r code instead of dplyr because dplyr won't read name with space & dash?
names(refine_original)[names(refine_original)=="Product code / number"] <- "product"

#Split the code and number at the dash; create new columns 'product_code' and 'product_number'
refine_original <- separate(refine_original, product, c("product_code", "product_number"), sep = "-" )

#create new product_category column filled according to product_code
#values: p =smartphone, v = TV, x = laptop, q = tablet

#first create list of values for code and category
product_code <- c("p", "v", "x", "q")
product_category <- c("smartphone", "TV", "laptop", "tablet")

#make these into new dataframe
valuekeys_df <- data.frame(product_code, product_category)

#left join valuekeys_df into refine_original so that all product_code values are kept, 
#and values from product_category are matched to them

refine_original <- left_join(refine_original, valuekeys_df)

#Warning message: joining factor and character vector, coercing into character vector
#Do I need to care? 

#Create a new column full_address that concatenates the three address fields
#(address, city, country), separated by commas
refine_original$full_address <- paste(refine_original$address, ", ", refine_original$city, ", ", refine_original$country)


#Create four dummy binary variables for product and four for company
#with the prefix company_ and product_

for (level in unique(refine_original$company)) {
  refine_original[paste("company", level, sep = "_")] <- ifelse(refine_original$company == level, 1, 0)
}

for (level in unique(refine_original$product_category)) {
  refine_original[paste("product", level, sep = "_")] <- ifelse(refine_original$product_category == level, 1, 0)
}

#create new data frame 'refine_clean'
refine_clean <- refine_original

#write to new CSV file
write.table(refine_clean, "~/Foundations_Exercises/refine_clean.csv",
row.names=FALSE, sep=",")


