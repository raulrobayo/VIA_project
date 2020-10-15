#Import data
data = read.csv("C:/Users/andre/Downloads/Q4 '20 Data Specialist Exercise - Data - Original Data.csv")

#delete description columns
data = data[-c(1,2),]

#explore data
summary(data)
str(data)
levels(Transformer.ID)
levels(Station)
levels(Status)

#histograms (from them, one can assume that normal values are around 0)
hist(data$Carbon.Dioxide, breaks = 10)
hist(data$Acetylene, breaks = 10)
hist(data$Ethane, breaks = 10)
hist(data$Ethylene, breaks = 10)
hist(data$Ethylene, breaks = 10)
boxplot(data$Ethylene) #the boxplots are also useful when identifying outliers
boxplot(data$Acetylene)
boxplot(data$Ethane)

#Change the type of the columns to ntegers/dates to keep it consistent
data$Hydrogen <- as.integer((levels(data$Hydrogen))[data$Hydrogen])
data$Ethane <- as.integer(data$Ethane)
data$Carbon.Monoxide <- as.integer(data$Carbon.Monoxide)
data$Unit.Number <- as.integer(data$Unit.Number)
data$Age <- as.integer((levels(data$Age))[data$Age])
data$MVA.Max <- as.integer((levels(data$MVA.Max))[data$MVA.Max])

#identify outliers, remove them and count NA values 
table(is.na(data))
summary(data)
which(data$Acetylene == -500)
which(data$Acetylene > 5000)
data = data[-c(347,348, 447),]

#Replace NA values with random values from underlying distribution
data$Hydrogen[is.na(data$Hydrogen)]  <- sample(data$Hydrogen[!is.na(data$Hydrogen)], sum(is.na(data$Hydrogen)), replace=F)
data$Acetylene[is.na(data$Acetylene)]  <- sample(data$Acetylene[!is.na(data$Acetylene)], sum(is.na(data$Acetylene)), replace=F)
data$Ethylene[is.na(data$Ethylene)]  <- sample(data$Ethylene[!is.na(data$Ethylene)], sum(is.na(data$Ethylene)), replace=F)
data$Ethane[is.na(data$Ethane)]  <- sample(data$Ethane[!is.na(data$Ethane)], sum(is.na(data$Ethane)), replace=F)
data$Methane[is.na(data$Methane)]  <- sample(data$Methane[!is.na(data$Methane)], sum(is.na(data$Methane)), replace=F)
data$Carbon.Dioxide[is.na(data$Carbon.Dioxide)]  <- sample(data$Carbon.Dioxide[!is.na(data$Carbon.Dioxide)], sum(is.na(data$Carbon.Dioxide)), replace=F)
data$Carbon.Monoxide[is.na(data$Carbon.Monoxide)]  <- sample(data$Carbon.Monoxide[!is.na(data$Carbon.Monoxide)], sum(is.na(data$Carbon.Monoxide)), replace=F)

#delete MVA max, as there are too many NA values (if amps required were to be available, variable could be used)
data =  data[,-c(14)]

#Remove the string characters from some cells and convert into integer for the Voltage variable
levels(Primary.Voltage)
data$Primary.Voltage[data$Primary.Voltage == "33000 V"] <- 33000
data$Primary.Voltage <- as.integer((levels(data$Primary.Voltage))[data$Primary.Voltage])

#verify the new classes
str(data)

#Fix the inferred birth date that produces the anomaly present
data$Inferred.Birth.Date <- as.character(data$Inferred.Birth.Date)
data$Inferred.Birth.Date[data$Inferred.Birth.Date == "1971-11-01"] <-	"1954-01-01"

#format the variables as dates
data$Inferred.Birth.Date <- as.Date(as.character(data$Inferred.Birth.Date), format = "%Y-%m-%d")
data$Measurement.Date <- as.Date(as.character(data$Measurement.Date), format = "%Y-%m-%d")

#recalculate the age to fix the anomaly
data$Age = as.integer(((data$Measurement.Date - data$Inferred.Birth.Date)/365.25))

#Transform Status column into a binary variable
data$Status = ifelse(data$Status == "Onsite", 1,0)
data$Status <- as.integer(data$Status)

#create column based on transmission type transformers
data$TType = ifelse(data$Primary.Voltage == 138000,1,0)

#normalize numerical variables so that all variables are in the same scale and can be used in machine learning algorithms
library(caret)
preproc1 <- preProcess(data[,c(1:7,13,14)], method=c("range"))
data[,c(1:7,13,14)] <- predict(preproc1, data[,c(1:7,13,14)])
summary(data)

#Principal component analysis to further explore the data and find variables that 
vars = data[,c(1:7,13,14)]
pca=prcomp(vars, scale=TRUE)
pca

library(ggplot2)
library(ggfortify)
autoplot(pca, data = vars, loadings = TRUE, loadings.label = TRUE )

#Export the clean DataFrame to CSV
write.csv(data, "C:/Users/andre/Downloads/Clean Data.csv", row.names = FALSE)

