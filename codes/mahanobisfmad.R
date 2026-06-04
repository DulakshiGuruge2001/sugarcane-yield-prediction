rm(list=ls())
library(FactoMineR)
library(factoextra)
library(MASS)  # For robust Mahalanobis distance

library(caret) # Machine Learning Library
library(xgboost) # XGBoost library
library(ggplot2)
library(factoextra)
library(clustMixType)
library(smotefamily)
library(DMwR2)
library(smotefamily)
library(e1071)

set.seed(123)
data =read.csv("C:/Users/sheno/OneDrive/Desktop/Final Project/Dataset/Full_dataset.csv")
str(data)
summary(data)

data <- na.omit(data)

#Train/set 80/20
set.seed(123)

# Define the test set size (20% of data)
size = floor(0.2 * nrow(data))

# Randomly sample indices for the test set
test_ind = sample(seq_len(nrow(data)), size = size)

# Split the dataset
test = data[test_ind, ]   # Test set
train = data[-test_ind, ]  # Training set
#train
qs= quantile(train$Yield, probs = c(0 ,3/4, 1))
# Slightly expand the range to safely cover all test values
qs[1] <- min(qs[1], min(test$Yield, na.rm = TRUE)) - 1
qs[3] <- max(qs[3], max(test$Yield, na.rm = TRUE)) + 1

# Now apply cut again
train$yieldcat <- cut(train$Yield, breaks = qs, labels = c("Low", "High"), include.lowest = TRUE)
test$yieldcat  <- cut(test$Yield,  breaks = qs, labels = c("Low", "High"), include.lowest = TRUE)


train=train[-14]
test=test[-14]
##for train set
num_vars <- sapply(train, is.numeric)  # Logical vector: TRUE for numeric, FALSE for categorical


scaled_num <- scale(train[, num_vars])
num_vars[20]=TRUE

# Convert categorical predictors to dummy variables
library(caret)
dummy_vars <- dummyVars(~ ., data = train[, !num_vars, drop = FALSE],fullRank = TRUE)  # Exclude response
encoded_cats <- predict(dummy_vars, newdata = train)

train_preprocessed <- data.frame(scaled_num, encoded_cats,train[20],stringsAsFactors = F)  # Keep response unchanged


train_scaled <- train_preprocessed



#for test
num_vars1 <- sapply(test, is.numeric)  # Logical vector: TRUE for numeric, FALSE for categorical

scaled_num1 <- scale(test[, num_vars1])
num_vars1[20]=TRUE


# Convert categorical predictors to dummy variables
library(caret)

encoded_cats1 <- predict(dummy_vars, newdata = test)

test_preprocessed <- data.frame(scaled_num1, encoded_cats1,test[20],stringsAsFactors = F)  # Keep response unchanged

test_scaled <- test_preprocessed


xtrain=train_scaled[,1:36]
ytrain=train_scaled[,37]
xtest=test_scaled[,1:36]
ytest=test_scaled[,37]

train=data.frame(xtrain,ytrain)
# Remove missing values
data <- na.omit(train)

# Run FAMD
famd_res <- FAMD(data, graph = F)

# Get FAMD scores (coordinates in lower-dimensional space)
scores <- famd_res$ind$coord

# Compute Robust Mahalanobis distance using MCD (Minimum Covariance Determinant)
mcd_res <- cov.mcd(scores)

# The robust Mahalanobis distances
robust_mahal_dist <- sqrt(mahalanobis(scores, mcd_res$center, mcd_res$cov))

# Set a threshold (e.g., 99% quantile)
threshold <- quantile(robust_mahal_dist, 0.95)
outliers <- which(robust_mahal_dist > threshold)

# Print outliers
print(outliers)

library(ggplot2)

# Create a data frame for coloring
outlier_labels <- ifelse(robust_mahal_dist > threshold, "Outlier", "Normal")

# Plot individuals with a proper legend
fviz_pca_ind(famd_res, label = "none", col.ind = outlier_labels, palette = c("blue", "red")) +
  ggtitle("Outlier Detection using FAMD with Robust Mahalanobis Distance") +
  scale_color_manual(name = "", values = c("Normal" = "blue", "Outlier" = "red")) +
  theme(plot.title = element_text(hjust = 0.5))  # Center title

