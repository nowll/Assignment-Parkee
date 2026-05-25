
# Sales Data Aggregation and Cleaning Documentation

## Overview

This documentation explains a Python script designed to merge, clean, and aggregate sales data from multiple branch CSV files. The script uses the `pandas` library to perform efficient data transformation, duplicate handling, aggregation, and CSV export operations.

---

## Requirements

Before running the script, ensure the following dependencies are installed:

- Python 3.x
- `pandas` library

---

## Installation

Install the required dependency using PowerShell or terminal:

```powershell
pip install pandas
````

---

## Input Files

The script expects the following CSV files to exist in the same directory as the Python script:

* `branch_a.csv`
* `branch_b.csv`
* `branch_c.csv`

Each CSV file must contain the following columns:

```text
transaction_id, branch, date, product_id, quantity, price, customer_id
```

---

## Processing Workflow

The script performs the following operations sequentially:

---

### 1. Data Ingestion

All CSV files are loaded into separate Pandas DataFrames and then concatenated into a single DataFrame.

### Example

```python id="k4s9mx"
file_names = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']

dataframes = [pd.read_csv(file) for file in file_names]

df = pd.concat(dataframes, ignore_index=True)
```

---

### 2. Missing Data Cleaning

Rows containing missing values (`NaN`) in critical columns are removed.

### Required Columns

* `transaction_id`
* `date`
* `customer_id`

### Example

```python id="q8y7nb"
df = df.dropna(subset=['transaction_id', 'date', 'customer_id'])
```

---

### 3. Data Type Conversion

The `date` column is converted from string format into native Pandas datetime objects for easier sorting and processing.

### Example

```python id="e5fr91"
df['date'] = pd.to_datetime(df['date'])
```

---

### 4. Duplicate Handling

The script removes duplicate transactions while preserving the most recent entry.

### Processing Steps

1. Sort the DataFrame by `date` in descending order
2. Remove duplicates based on `transaction_id`
3. Keep the newest transaction record

### Example

```python id="u2ld8q"
df = df.sort_values(by='date', ascending=False)

df = df.drop_duplicates(
    subset=['transaction_id'],
    keep='first'
)
```

---

### 5. Total Sales Calculation

A new column named `total` is created by multiplying the `quantity` column by the `price` column.

### Formula

```text
total = quantity × price
```

### Example

```python id="z7n4kf"
df['total'] = df['quantity'] * df['price']
```

---

### 6. Data Aggregation

The cleaned dataset is grouped by branch, and the total sales value is calculated for each branch.

### Example

```python id="h3pc91"
total_sales_df = (
    df.groupby('branch')[['total']]
      .sum()
      .reset_index()
)
```

### Note

Using double brackets `[['total']]` ensures the result remains a DataFrame and avoids Pyright static type warnings.

---

### 7. Exporting Results

The aggregated sales data is exported into a new CSV file.

### Output File

```text
total_sales_per_branch.csv
```

### Example

```python id="r7fpa0"
total_sales_df.to_csv(
    'total_sales_per_branch.csv',
    index=False
)
```

---

## Full Script Code

```python id="d8sa72"
import pandas as pd

# 1. Combine all CSV files into one DataFrame
file_names = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']

dataframes = [pd.read_csv(file) for file in file_names]

df = pd.concat(dataframes, ignore_index=True)

# 2. Clean the data
df = df.dropna(
    subset=['transaction_id', 'date', 'customer_id']
)

df['date'] = pd.to_datetime(df['date'])

# 3. Handle duplicates (Keep newest)
df = df.sort_values(by='date', ascending=False)

df = df.drop_duplicates(
    subset=['transaction_id'],
    keep='first'
)

# 4. Calculate total sales
df['total'] = df['quantity'] * df['price']

# 5. Group by branch and output
# Double brackets [['total']] avoid Pyright warnings
total_sales_df = (
    df.groupby('branch')[['total']]
      .sum()
      .reset_index()
)

# 6. Export result
total_sales_df.to_csv(
    'total_sales_per_branch.csv',
    index=False
)

print(
    "Data processing complete. "
    "Saved to 'total_sales_per_branch.csv'"
)
```

---

## Expected Output

### File: `total_sales_per_branch.csv`

```csv
branch,total
A,265.0
B,380.0
C,480.0
```

---

## Troubleshooting

### ModuleNotFoundError

If you encounter:

```text
ModuleNotFoundError: No module named 'pandas'
```

Install the required dependency:

```powershell
pip install pandas
```

---

### Pyright Warning on `.reset_index()`

If Pyright shows warnings during the `groupby()` operation, ensure the code uses:

```python
[['total']]
```

instead of:

```python
['total']
```

This ensures the grouped result remains a DataFrame rather than a Series.

---

## Summary

This project demonstrates a complete data processing workflow using Python and Pandas, including:

* Reading multiple CSV files
* Merging datasets
* Cleaning incomplete records
* Converting data types
* Removing duplicate transactions
* Calculating sales metrics
* Aggregating branch sales data
* Exporting results into a CSV file

The implementation is practical, beginner-friendly, and suitable for learning real-world data processing and ETL concepts using Python.

---
