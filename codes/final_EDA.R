# Load necessary libraries
library(cluster)
library(dplyr)
library(rlang)
library(DescTools)
library(ggplot2)
library(FactoMineR)
library(factoextra)
library(data.table)

#Load the dataset
train_data <- read.csv("C:/Users/USER/OneDrive/Desktop/Final/train_data.csv")
str(train_data)

# Remove Yield_Category
train_data <- train_data %>%
  select(-c(Yield_Category, YieldOldGrade, TargetOldGrade, YieldGrade, TargetGrade, ActionWater))

# Identify character columns
character_cols <- sapply(train_data, is.character)
#character_cols

# Convert character columns to factors
train_data[, character_cols] <- lapply(train_data[, character_cols], as.factor)
str(train_data)

# Apply FAMD
famd_model <- FAMD(train_data, graph = FALSE)

# View summary
summary(famd_model)

# Visualize the scree plot (to assess the percentage of variance explained by each dimension)
fviz_screeplot(famd_model, addlabels = TRUE, ylim = c(0, 7))
#Variable Contributions in FAMD
fviz_famd_var(famd_model, repel = TRUE, title = "Variable Contributions in FAMD")
# Contribution to the first dimension
fviz_contrib(famd_model, "var", axes = 1)
# Contribution to the second dimension
fviz_contrib(famd_model, "var", axes = 2)
#The red dashed line on the graph above indicates the expected average value, If the contributions were uniform

###########Quantitative variables
# Visualize the quantitative variables on the factor map (with uniform color for variables)
fviz_famd_var(famd_model, "quanti.var", repel = TRUE,
              col.var = "black")
#the graph of variables (correlation circle) shows the relationship between variables, the quality of the representation of variables, as well as, the correlation between variables and the dimensions.

# Visualize the quantitative variables on the factor map with a gradient color scale
# Gradient based on cos2 values (quality of representation of the variables)
fviz_famd_var(famd_model, "quanti.var", 
              col.var = "cos2",  # Color based on cos2 values
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),  # Gradient color scheme
              repel = TRUE)  # Avoid label overlap

#############Graph of qualitative variables
# Visualize the quantitative variables on the factor map (with uniform color for variables)
fviz_famd_var(famd_model, "quali.var", col.var = "contrib", 
              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
)
#The plot above shows the categories of the categorical variables.

###############Graph of individuals(clustering)
#dev.new() 
#fviz_famd_ind(famd_model,
#              col.ind = "cos2",  # Color by quality of representation
#              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
#              addEllipses = TRUE,
#              ellipse.type = "confidence",
#              repel = TRUE)  # Avoid text overlapping


########################################################
# --- Loading Calculation ---
train_data <- read.csv("C:/Users/USER/OneDrive/Desktop/Final/train_data.csv")
# Select just numeric columns
train_data_numeric <- train_data[, sapply(train_data, is.numeric)]

# Calculate variable loadings
loadings <- cor(train_data_numeric)

# Prepare loadings for plotting
#Create the loading variables
PC1 <- loadings[1,]
PC2 <- loadings[2,]

#Create the plot
plot(PC1, PC2, pch=16, col="blue", xlab = "PC1", ylab = "PC2", main = "Loading Variables")
text(PC1, PC2, labels=rownames(loadings), cex = 0.6, pos=4, col="red")

# --- Interpretation ---
# - The loadings indicate the correlation between the original variables
#   and the principal components.
# - Variables with high loadings (positive or negative) on a component
#   are strongly associated with that component.
# - You can use these loadings to understand which variables contribute
#   most to each component, and therefore which variables
#   are most important for explaining the variance in your data.

# Apply FAMD
famd_model <- FAMD(train_data, graph = FALSE)

# Extract factor loadings (contributions of variables to dimensions)
factor_loadings <- get_famd_var(famd_model)$coord

# Convert to a data frame for better readability
factor_loadings_df <- as.data.frame(factor_loadings)

# Display the factor loading matrix
print(factor_loadings_df)

# Optionally, you can round the values for better readability
factor_loadings_rounded <- round(factor_loadings_df, 3)
print(factor_loadings_rounded)



