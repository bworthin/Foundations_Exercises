#Data Wrangling Exercise 1

#get plyr
install.packages('plyr')
library(plyr)

#get dplyr
install.packages('dplyr')
library(dplyr)

#Import csv file to data frame
refine_original <- read_csv("~/Foundations_Exercises/refine_original.csv")



#Clean up 'company' column so brand names are consistent
#use tolower() to get to lower case
refine_original$company <- tolower(df$company)
#Then substitute correctly spelled names - there must be a better way to do this with lapply or a for loop?
refine_original$company <- gsub(pattern = "^a.*", replacement = "akzo", x = refine_original$company)
refine_original$company <- gsub(pattern = "^u.*", replacement = "unilever", x = refine_original$company)
refine_original$company <- gsub(pattern = "^p.*", replacement = "philips", x = refine_original$company)
refine_original$company <- gsub(pattern = "^f.*", replacement = "philips", x = refine_original$company)

#Rename 'product code / number' column to 'product' 
#Using base r code instead of dplyr b/c dplyr won't read name with space & dash
names(refine_original)[names(refine_original)=="Product code / number"] <- "product"

#Split the code and number at the dash; create new columns 'product_code' and 'product_number'
separate(refine_original, product, c("product_code", "product_number"), sep = "-" )



#Add column 'product_category' based on product code. p smartphone, v TV, x laptop, 
#q tablet
#create new column name, then assign value with lapply looking a product code, if statement
##refine_original$product_category <- 

#Create a new column full_address that concatenates the three address fields
#(address, city, country), separated by commas
refine_original$full_address <- paste(refine_original$address, ", ", refine_original$city, ", ", refine_original$country)


#Create four dummy binary variables for product and four for company
#with the prefix company_ and product_

#write to new CSV file
# write.table(refine_clean, "~/Foundations_Exercises/refine_original.csv",
#row.names=FALSE, sep=",")

