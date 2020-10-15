# VIA Home Exercise for Data Technician Position - Andres Robayo-Romero

This exercise's main task was to prepare the dataset for ingestion before passing it on to another team member who will perform feature engineering and modeling. To do so, I created a script that explores the data, cleans it, and fixes certain issues present. 

# Programming Language Used

R was the programming language used to perform analyses and clean the data.

# How to Use?

The original dataset that was provided needs to be imported into the environment. When testing the code in another computer, one needs to adjust the location of the original dataset to match the location in the computer, as well as modify the location in which the clean dataset (at the end of the script) will be saved.

*Modify these lines*

> Line 2: data = read.csv("C:/Users/andre/Downloads/Q4 '20 Data Specialist Exercise - Data - Original Data.csv")

> Line 93: write.csv(data, "C:/Users/andre/Downloads/Clean Data.csv", row.names = FALSE)

Once these locations are modified, one can fully run the code that modifies the dataset. Certain boxplots, bar charts and graphs will not be exported and if the user wishes to see them, he or she can do so by looking at the plots in the programming language. 


