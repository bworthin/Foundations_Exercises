#Data Wrangling Exercise 1
#get plyr
install.packages('plyr')
library(plyr)
#get dplyr
install.packages('dplyr')
library(dplyr)

#Imported using import option. But here's the code it executed:
refine_original <- read_csv("~/Foundations_Exercises/refine_original.csv")



#Clean up the 'company' column so all of the misspellings of the brand names
#are standardized, same capitalization, etc.

# select company column, then 
#use tolower() to get to lower case
#then lapply or vapply? and sub or gsub? if starts with f or p, phillips, if starts with v, etc.

#Rename 'product code / number' column to 'product' 
#Using base r code instead of dplyr b/c dplyr won't read name with space & dash
names(refine_original)[names(refine_original)=="Product code / number"] <- "product"

#Split the code and number at the dash; create new columns 'product_code' and 'product_number'
separate(refine_original, product code,c("product_code", "product_number"), sep = "-" )



#Add column 'product category' based on product code. p smartphone, v TV, x laptop, 
#q tablet
#????

#Create a new column full_address that concatenates the three address fields
#(address, city, country), separated by commas
refine_original$full_address <- paste(refine_original$address, ", ", refine_original$city, ", ", refine_original$country)


#Create four dummy binary variables for product and four for company
#with the prefix company_ and product_

#write to new CSV file
# write.table(refine_clean, "~/Foundations_Exercises/refine_original.csv",
#row.names=FALSE, sep=",")

