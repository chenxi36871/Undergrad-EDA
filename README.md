# Undergrad-EDA

This repository contains all my work (3 homework and 1 final project) in my undergraduate study course -- Exploratory Data Analysis. In this class, I use R language.

## Homework 1
The [dataset](https://github.com/chenxi36871/Undergrad-EDA/blob/main/hw1/ToyotaCorolla_part.csv) contains 1436 records of second-hand cars features and sales information. The purpose of this homework is to predict the sale price of second-hand car based on its objective features.

[project code (in R language)](https://github.com/chenxi36871/Undergrad-EDA/blob/5e3788fd04cafc5080cb09cbb5a4e2d836cf8517/hw1/hw1/hw1.R) 

[final report (in Chinese)](https://github.com/chenxi36871/Undergrad-EDA/blob/5e3788fd04cafc5080cb09cbb5a4e2d836cf8517/hw1/2018110760%E6%9D%8E%E6%99%A8%E8%8C%9C.pdf)


## Homework 2
The [dataset](https://github.com/chenxi36871/Undergrad-EDA/blob/5e3788fd04cafc5080cb09cbb5a4e2d836cf8517/hw2/germancredit.csv) contains information of 1000 loan applications (characteristics and results(approved or not)). The description of the variables is [here](https://github.com/chenxi36871/Undergrad-EDA/blob/5e3788fd04cafc5080cb09cbb5a4e2d836cf8517/hw2/germancreditDescription.docx). The purpose of this homework is to train a logistic regression model to predict whether a loan application will be approved or not.
Split the whole dataset to 900 for training data and 100 for test data.

[project code (in R language)](https://github.com/chenxi36871/Undergrad-EDA/blob/main/hw2/hw2/hw2.R)

[final report (in Chinese)](https://github.com/chenxi36871/Undergrad-EDA/blob/main/hw2/2018110760%E6%9D%8E%E6%99%A8%E8%8C%9C.pdf)


## Homework 3
The [dataset](https://github.com/chenxi36871/Undergrad-EDA/blob/main/hw3/cereals.csv) contains nutrition information of 77 different cereal.
(1) Please do some exploratory analysis on given data. Use PCA to generate comprehensive features to show the nutrition of cereal.
(2) Based on the comprehensive features we got from question (1), group cereals by manufacture and try to find what's in common and what's different.

[project code (in R language)](https://github.com/chenxi36871/Undergrad-EDA/blob/main/hw3/edahm3.R)
[final report (in Chinese)](https://github.com/chenxi36871/Undergrad-EDA/blob/main/hw3/2018110760%E6%9D%8E%E6%99%A8%E8%8C%9C.pdf)


## Final Project
In the final project, we try to predict whether a person will have coronary heart disease in the next decade based on their current health condition. The dataset is [here](https://github.com/chenxi36871/Undergrad-EDA/blob/main/final_project/heartdisease.csv). This dataset contains 15 variables and 4238 observations.

Below is a simple outline of my project.

### Data Cleaning & Preprocessing
**Missing Values and Outliers**

The total dataset contains 4238 observations and only 3656 observations are without any missing values, which means there are 13.7% observations that contains missing values. Considering this is a quite high percentage, we don't want to delete this much data. Therefore, we use KNN algorithm to fill in the missing value.

And there're only 1.8% observations containing outliers. So we deleted them.

**Imbalanced Data**

Since in natural world, there are way less people (14%) who suffer from coronary heart disease than who don't. Our data is very imbalanced, which will affect the performance of the model. We use SMOTE algorithm to resample original dataset and got a new balanced dataset containing 6743 observations.

### Visulization
### Modeling
I trained different models (Logistic Regression, Decision Tree, Random Forest, SVM) and compared their performances given different size of the dataset. The learning rate plot is as below:

<img width="576" alt="image" src="https://user-images.githubusercontent.com/82719564/194443230-95902a7b-3bc4-4bbe-95a0-563ad1ec2cc1.png">

***code (in R language)***
[preprocessing](https://github.com/chenxi36871/Undergrad-EDA/blob/main/final_project/pre.R)
[visualization](https://github.com/chenxi36871/Undergrad-EDA/blob/main/final_project/%E5%8F%AF%E8%A7%86%E5%8C%96.R)
[modeling](https://github.com/chenxi36871/Undergrad-EDA/blob/main/final_project/logistic.R)

***report***
[pdf](https://github.com/chenxi36871/Undergrad-EDA/blob/main/final_project/%E5%8D%81%E5%B9%B4%E5%86%85%E5%86%A0%E5%BF%83%E7%97%85%E5%8F%91%E7%97%85%E6%A6%82%E7%8E%87%E6%8E%A2%E7%B4%A2.pdf)
[slides](https://github.com/chenxi36871/Undergrad-EDA/blob/main/final_project/EDA.pptx)
