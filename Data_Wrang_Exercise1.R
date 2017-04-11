#Data Wrangling Exercise 1

#get plyr
install.packages('plyr')
library(plyr)

#get dplyr
install.packages('dplyr')
library(dplyr)

#get tidyr
install.packages('tidyr')
library(tidyr)

#Import csv file to data frame
refine_original <- read_csv("~/Foundations_Exercises/refine_original.csv")

#Use tolower() to convert company names to lower case
refine_original$company <- tolower(df$company)

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

#Add column 'product_category' based on product code. 
#create a function that converts product code into a category - p =smartphone, 
#v = TV, x = laptop, q = tablet
cat_convert <- function(x) {
  if (x == "p") {
    return("smartphone")
    else if (x == "v") {
      return("TV")
      else if (x == "x") {
        return("laptop")
        else if (x == "q") {
          return("tablet")
        }
      }
    }
  }
}
 
    
#create new column for product category, then assign value using cat_convert function
refine_original$product_category <- cat_convert(refine_original$product_code)

for (pc in refine_original$product_code) {
  if (pc == "p") {
    refine_original$product_category <- "smartphone"
  }
}
#Create a new column full_address that concatenates the three address fields
#(address, city, country), separated by commas
refine_original$full_address <- paste(refine_original$address, ", ", refine_original$city, ", ", refine_original$country)


#Create four dummy binary variables for product and four for company
#with the prefix company_ and product_

#write to new CSV file
# write.table(refine_clean, "~/Foundations_Exercises/refine_original.csv",
#row.names=FALSE, sep=",")

