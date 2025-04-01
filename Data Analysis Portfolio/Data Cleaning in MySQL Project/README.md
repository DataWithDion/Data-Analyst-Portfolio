Data Cleaning in SQL: Cafe Sales Dataset

📌 Project Overview

This project illustrates data cleaning methods in MySQL on a dirty dataset of cafe sales transactions. The goal is to clean and normalize the data to prepare it for further analysis.

🛠 Cleaning Techniques Used

Data cleaning involves several steps, which are:

1️⃣ Inspect and Understand the Data

Reviewed the dataset using SELECT * to check its structure.

Used DESCRIBE dirty_cafe_sales; to inspect column types and detect inconsistencies.

2️⃣ Backup the Raw Data

Created a backup table before making any modifications to preserve the original data.

3️⃣ Standardizing Column Names

Renamed columns to maintain uniformity and readability (e.g., Transaction ID → Transaction_ID).

4️⃣ Identifying and Handling Duplicates

Used ROW_NUMBER() to detect duplicate Transaction_ID records.

No duplicates were found in the dataset.

5️⃣ Handling Missing & Erroneous Values

Replaced ERROR, UNKNOWN, and empty values ('') with NULL for:

Transaction_Date

Total_Spent

Item

Payment_Method

Location

Altered Transaction_Date to DATE type.

Used forward-filling to replace missing transaction dates.

Computed the average Total_Spent and replaced missing values with the computed average.

Altered Total_Spent to DOUBLE for consistency.

📂 Project Files

data_cleaning.sql → SQL script for data cleaning.

dataset/dirty_cafe_sales.csv → Raw, uncleaned dataset.

dataset/cleaned_cafe_sales.csv → Cleaned dataset after SQL processing.

🚀 How to Use

Import the dataset into MySQL.

Run the data_cleaning.sql script to clean the data.

Export the cleaned dataset for further analysis.

🔍 Key Insights & Business Value

Ensures data coherency and integrity for analysis.

Eliminates errors that could mislead decision-making.

Prepares data for business intelligence and reporting.

✍️ Author

Dion Hasolli

📧 Contact: dionhasolli30@gmail.com

🌐 Portfolio: https://github.com/DataWithDion/Data-Analyst-Portfolio

This work is part of my Data Analytics Portfolio, showcasing SQL-based data cleaning techniques. 


