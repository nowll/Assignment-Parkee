# University API Data Processing Documentation

## Overview

This documentation covers the Python script designed to interact with the Hipolabs Universities API. The script fetches university data dynamically based on a country keyword, converts it into a tabular format, and filters out incomplete data.

---

# Requirements

- Python 3.x
- `requests` library (for handling HTTP GET requests)
- `pandas` library (for data manipulation)

---

# Installation

## PowerShell

```powershell id="n7a4fp"
pip install requests pandas
````

---

# API Endpoint Details

| Item            | Description                                                    |
| --------------- | -------------------------------------------------------------- |
| Base URL        | `http://universities.hipolabs.com/search`                      |
| Query Parameter | `?country=<COUNTRY_NAME>`                                      |
| Authentication  | None required                                                  |
| Rate Limiting   | If hitting `403` errors, standard unauthenticated limits apply |

---

# Processing Logic

## 1. API Request

Uses `requests.get()` to fetch JSON data for the target country (e.g., `"United States"`).

### Example

```python id="m9q3ke"
response = requests.get(
    "http://universities.hipolabs.com/search?country=United States"
)
```

---

## 2. DataFrame Conversion

Loads the raw JSON array into a Pandas DataFrame.

### Example

```python id="cb6v8j"
df = pd.DataFrame(response.json())
```

---

## 3. Column Selection

Extracts only the required columns:

* `name`
* `web_pages`
* `country`
* `domains`
* `state-province`

### Example

```python id="u2vx8n"
df = df[
    ["name", "web_pages", "country", "domains", "state-province"]
]
```

---

## 4. Column Renaming

Renames the columns into proper title case formatting.

### Example

```python id="5fnt9s"
df.columns = [
    "Name",
    "Web Pages",
    "Country",
    "Domains",
    "State Province"
]
```

---

## 5. Data Filtering

### Purpose

Cleans and filters the dataset to ensure only complete university records are retained.

### Processing Steps

1. Converts empty strings `""` into `None`
2. Uses `.dropna()` to remove rows without a registered `State Province`

### Example

```python id="r8dk61"
df["State Province"] = df["State Province"].replace("", None)

filtered_df = df.dropna(subset=["State Province"])
```

---

## 6. Output

The script:

* Prints the total count of filtered universities
* Displays a sample table in the console

### Example

```python id="f3pwz2"
print(f"Total Filtered Universities: {len(filtered_df)}")

print(filtered_df.head())
```

---

# Expected Output Example

| Name                | Country       | State Province |
| ------------------- | ------------- | -------------- |
| Stanford University | United States | California     |
| Harvard University  | United States | Massachusetts  |

---

# Summary

This script demonstrates a complete API data processing workflow:

* Fetching remote JSON data
* Transforming data into a structured DataFrame
* Cleaning incomplete records
* Producing formatted output for analysis

The implementation is lightweight, efficient, and suitable for beginner-to-intermediate Python data processing projects.

---
