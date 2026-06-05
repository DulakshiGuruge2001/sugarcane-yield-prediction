# Sugarcane Yield Prediction

A comprehensive machine learning project for predicting sugarcane crop yields using advanced data analysis, clustering techniques, and gradient boosting methods. This project leverages South Asian sugarcane production data to build predictive models that can assist farmers and agricultural experts in yield forecasting.

## 📋 Project Overview

This repository implements an end-to-end machine learning pipeline for sugarcane yield prediction, combining exploratory data analysis (EDA), statistical methods, clustering algorithms, and XGBoost classification models. The project aims to classify yield levels (Low/High) based on agricultural and environmental features.

### Key Features

- **Exploratory Data Analysis (EDA)** using FAMD (Factor Analysis of Mixed Data)
- **Clustering Analysis** with K-Prototypes algorithm for mixed data types
- **Outlier Detection** using robust Mahalanobis distance
- **Advanced Predictive Modeling** with XGBoost
- **Feature Importance Analysis** to identify key yield predictors
- **Comprehensive Performance Evaluation** with confusion matrices and ROC curves

---

## 📂 Repository Structure

```
sugarcane-yield-prediction/
├── README.md                          # Project documentation
├── Data set/                          # Dataset directory
│   ├── south_asian_sugarcane_large.xlsx  # Primary dataset (Excel format)
│   ├── train1.csv                     # Training dataset (larger set)
│   ├── test1.csv                      # Test dataset (larger set)
│   ├── train_data_my.csv              # Training dataset (alternate)
│   └── test_data_my.csv               # Test dataset (alternate)
├── codes/                             # Source code directory
│   ├── final_EDA.R                    # Exploratory Data Analysis in R
│   ├── final_EDA.ipynb                # Exploratory Data Analysis in Jupyter Notebook
│   ├── cluster.R                      # K-Prototypes Clustering implementation
│   ├── mahanobisfmad.R                # Outlier detection using Mahalanobis distance
│   └── xg boost.R                     # XGBoost model training and evaluation
├── Report/                            # Project reports directory
└── Presentation/                      # Presentation materials
```

---

## 🗂️ Code Modules

### 1. **final_EDA.R & final_EDA.ipynb** - Exploratory Data Analysis

**Purpose:** Comprehensive statistical exploration of the sugarcane dataset

**Key Techniques:**
- FAMD (Factor Analysis of Mixed Data) for dimensionality reduction
- Scree plot analysis to assess variance explained
- Variable contribution analysis
- Loading matrix computation
- Correlation circle visualization

**Key Libraries:**
- `FactoMineR` - FAMD implementation
- `factoextra` - Visualization functions
- `ggplot2` - Advanced plotting
- `dplyr` - Data manipulation

**Outputs:**
- Scree plots showing variance explained by each dimension
- Variable contribution heatmaps
- Quantitative and qualitative variable visualizations
- Factor loading matrices

---

### 2. **cluster.R** - K-Prototypes Clustering

**Purpose:** Identify natural groupings in the sugarcane data using mixed data types

**Methodology:**
- Handles both numeric and categorical variables simultaneously
- Automatically detects column types (numeric/categorical/factor)
- Scales numeric variables for fair distance computation
- Applies K-Prototypes algorithm (hybrid of K-means and K-modes)
- Validates clusters using silhouette analysis and elbow method

**Key Libraries:**
- `clustMixType` - K-Prototypes clustering
- `clusterCrit` - Cluster validation metrics
- `FactoMineR` - FAMD for preprocessing
- `factoextra` - Visualization

**Process:**
1. Remove missing values
2. Identify numeric and categorical variables
3. Scale numeric data
4. Calculate within-cluster sum of squares (WSS) for elbow method
5. Determine optimal k value
6. Run K-Prototypes clustering
7. Analyze cluster characteristics
8. Visualize using PCA

**Outputs:**
- Elbow plot for optimal k determination
- Cluster assignments
- Cluster centers
- Numeric and categorical summaries per cluster
- Silhouette scores
- Clustered dataset CSV

---

### 3. **mahanobisfmad.R** - Outlier Detection

**Purpose:** Identify and visualize outliers using robust statistical methods

**Methodology:**
- Uses FAMD for dimensionality reduction
- Computes Robust Mahalanobis Distance using MCD (Minimum Covariance Determinant)
- Sets outlier threshold at 95th percentile
- Creates visual distinction between normal and outlier observations

**Key Libraries:**
- `MASS` - Robust covariance estimation
- `FactoMineR` - FAMD
- `factoextra` - PCA visualization
- `caret` - Data preprocessing
- `xgboost` - Machine learning

**Process:**
1. Load and preprocess dataset
2. 80/20 train-test split
3. Create yield categories based on quantiles
4. Scale numeric variables
5. Encode categorical variables as dummy variables
6. Apply FAMD to training data
7. Compute robust Mahalanobis distances
8. Identify outliers above 95th percentile threshold
9. Visualize outliers on PCA plot

**Outputs:**
- List of outlier indices
- PCA visualization with outlier highlighting
- Robust distance calculations

---

### 4. **xg boost.R** - XGBoost Classification Model

**Purpose:** Build and validate a predictive model for yield classification (Low/High)

**Methodology:**
- Two-stage approach: initial full model, then feature importance filtering
- K-means clustering on yield to create binary labels
- Systematic hyperparameter tuning via grid search
- Cross-validation for robust model evaluation
- Feature importance analysis to identify key predictors

**Key Libraries:**
- `xgboost` - Gradient boosting framework
- `caret` - Model training and evaluation
- `ROCR` - ROC curve and AUC analysis
- `DMwR2` & `smotefamily` - Class imbalance handling

**XGBoost Hyperparameters:**
```
- nrounds: 1000 (number of boosting rounds)
- max_depth: 3 (tree depth)
- eta: 0.01 (learning rate)
- gamma: 0.3 (pruning threshold)
- colsample_bytree: 0.6 (feature sampling)
- min_child_weight: 5 (min sum of instance weights in child)
- subsample: 0.8 (sample fraction)
```

**Process:**
1. Load and preprocess data
2. Create binary yield categories using K-means
3. Scale numeric features
4. Encode categorical variables
5. Train initial XGBoost model
6. Extract feature importance
7. Retrain using only important features
8. Evaluate with confusion matrices
9. Calculate ROC-AUC scores
10. Fine-tune hyperparameters for optimal performance

**Outputs:**
- Confusion matrices (training and test sets)
- Precision, Recall, F1-scores
- ROC curves and AUC values
- Feature importance rankings
- Final predictions

---

## 📊 Datasets

### Data Files Location: `Data set/`

| File | Size | Purpose |
|------|------|---------|
| `south_asian_sugarcane_large.xlsx` | ~5.1 MB | Primary comprehensive dataset in Excel format |
| `train1.csv` | ~7.6 MB | Larger training set (comma-separated) |
| `test1.csv` | ~1.9 MB | Larger test set (comma-separated) |
| `train_data_my.csv` | ~6.0 MB | Alternative training dataset |
| `test_data_my.csv` | ~1.5 MB | Alternative test dataset |

### Data Characteristics

- **South Asian Region**: India, Pakistan, Bangladesh, and other South Asian countries
- **Variables**: Mix of numeric (rainfall, temperature, soil metrics) and categorical (region, crop variety) features
- **Target Variable**: Sugarcane yield (continuous) / Yield category (binary classification)
- **Data Type Split**: 97.9% Jupyter Notebook, 2.1% R scripts

---

## 🛠️ Installation & Setup

### Prerequisites

- **R** (version 3.6+)
- **RStudio** (recommended IDE)
- **Jupyter Notebook** (for .ipynb files)
- **Python** (3.7+ for Jupyter support)

### Required R Packages

```r
# Install packages
install.packages(c(
  "FactoMineR",      # FAMD
  "factoextra",      # Visualization
  "clustMixType",    # K-Prototypes
  "clusterCrit",     # Cluster validation
  "cluster",         # Clustering algorithms
  "dplyr",           # Data manipulation
  "ggplot2",         # Visualization
  "caret",           # Machine learning
  "xgboost",         # XGBoost
  "MASS",            # Robust statistics
  "ROCR",            # ROC analysis
  "DMwR2",           # Data mining utilities
  "smotefamily",     # Class imbalance handling
  "e1071",           # SVM and utilities
  "data.table"       # Efficient data operations
))
```

### Python Packages (for Jupyter notebooks)

```bash
pip install jupyter pandas numpy scikit-learn matplotlib seaborn
```

---

## 🚀 Quick Start Guide

### Running the Analysis Pipeline

#### 1. **Exploratory Data Analysis**
```r
# Open and run final_EDA.R in RStudio
source("codes/final_EDA.R")
```

#### 2. **Clustering Analysis**
```r
# Run K-Prototypes clustering
source("codes/cluster.R")
```

#### 3. **Outlier Detection**
```r
# Detect outliers using Mahalanobis distance
source("codes/mahanobisfmad.R")
```

#### 4. **XGBoost Prediction Model**
```r
# Train and evaluate the predictive model
source("codes/xg boost.R")
```

#### 5. **Jupyter Notebook (Alternative)**
```bash
jupyter notebook codes/final_EDA.ipynb
```

---

## 📈 Key Findings & Results

### Model Performance

Based on the XGBoost model:
- **Approach**: Binary classification (Low/High yield)
- **Data Split**: 80% training, 20% testing
- **Evaluation Metrics**: Accuracy, Precision, Recall, F1-score, ROC-AUC
- **Feature Selection**: Importance-based filtering to remove non-significant variables

### Clustering Insights

- **Algorithm**: K-Prototypes with optimal k determination
- **Silhouette Analysis**: Used for cluster quality validation
- **Findings**: Natural groupings in yield based on agricultural practices and environmental factors

### Dimensionality Analysis

- **FAMD Results**: Factor analysis reveals key dimensions explaining yield variance
- **Variable Contributions**: Both numeric and categorical variables contribute to yield differences
- **Scree Plot**: Shows cumulative variance explained by principal factors

---

## 📊 Visualization & Interpretation

### Key Visualizations

1. **Scree Plots**: Variance explained by FAMD dimensions
2. **Correlation Circles**: Variable relationships and contributions
3. **Cluster Plots**: PCA visualization of K-Prototypes results
4. **Outlier Detection Maps**: Mahalanobis distance visualizations
5. **ROC Curves**: Model performance across probability thresholds
6. **Feature Importance Charts**: XGBoost variable rankings

---

## 🔍 Model Evaluation

### Confusion Matrix Interpretation

The XGBoost model provides:
- **True Positives/Negatives**: Correctly classified yields
- **False Positives/Negatives**: Misclassification analysis
- **Sensitivity/Specificity**: Model's ability to identify each yield category
- **Positive/Negative Predictive Value**: Precision metrics

### Cross-Validation

- **Method**: 3-5 fold cross-validation
- **Purpose**: Prevent overfitting and ensure model generalization
- **Best Model Selection**: Based on minimal difference between training and test accuracy

---

## 📝 Methodology Notes

### Data Preprocessing

1. **Missing Values**: Removed using `na.omit()`
2. **Type Conversion**: Character columns converted to factors
3. **Feature Scaling**: Numeric variables standardized using z-score normalization
4. **Encoding**: Categorical variables converted to dummy variables via `dummyVars()`

### Statistical Techniques

- **FAMD**: Combines PCA for numeric and MCA for categorical variables
- **K-Prototypes**: Hybrid algorithm handling mixed data types
- **Robust Mahalanobis Distance**: MCD for outlier detection resistant to extreme values
- **XGBoost**: Gradient boosting with regularization for classification

### Hyperparameter Optimization

- **Grid Search**: Systematic exploration of parameter combinations
- **Early Stopping**: Prevents overfitting during boosting rounds
- **Feature Importance Filtering**: Removes low-impact variables for improved generalization

---

## 📊 Output Files

Models generate the following outputs:

1. **Clustered Data**: `kproto_clustered_data.csv` - Data with cluster assignments
2. **Predictions**: Test set predictions with class probabilities
3. **Visualizations**: PNG/PDF plots saved from R graphics
4. **Model Objects**: Trained models for future predictions
5. **Evaluation Reports**: Confusion matrices and performance metrics

---

## 🤝 Contributing

Contributions are welcome! To enhance this project:

1. Improve model accuracy through feature engineering
2. Implement additional algorithms (Random Forest, Neural Networks)
3. Optimize code efficiency and performance
4. Expand documentation and examples
5. Add more comprehensive unit tests

---

## 📄 License

This project is open source and available for educational and research purposes.

---

## 👨‍💻 Author

**Dulakshi Guruge**  
Repository: [sugarcane-yield-prediction](https://github.com/DulakshiGuruge2001/sugarcane-yield-prediction)

---

## 📞 Support & Contact

For questions, issues, or collaboration opportunities:
- Open an issue in the repository
- Review the code documentation in each script
- Check the Jupyter notebooks for detailed explanations

---

## 🔗 References & Resources

### Key Techniques
- **FAMD**: [FactoMineR Documentation](http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/115-famd-factor-analysis-of-mixed-data-in-r/)
- **K-Prototypes**: [clustMixType Package](https://cran.r-project.org/package=clustMixType)
- **XGBoost**: [Official XGBoost Documentation](https://xgboost.readthedocs.io/)

### Agricultural Context
- South Asian sugarcane production systems
- Yield prediction methodologies
- Feature importance in agricultural modeling

---

## 📋 Changelog

**Latest Update**: June 5, 2026
- Initial repository setup with comprehensive analysis pipeline
- Five core R analysis scripts
- Multiple dataset formats for flexibility
- Complete documentation and methodology

---

**Last Updated**: 2026-06-05  
**Status**: Active Development
