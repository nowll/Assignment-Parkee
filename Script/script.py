import pandas as pd

file_names = ['branch_a.csv', 'branch_b.csv', 'branch_c.csv']

dataframes = [pd.read_csv(file) for file in file_names]
df = pd.concat(dataframes, ignore_index=True)

df = df.dropna(subset=['transaction_id', 'date', 'customer_id'])

df['date'] = pd.to_datetime(df['date'])

df = df.sort_values(by='date', ascending=False)
df = df.drop_duplicates(subset=['transaction_id'], keep='first')
df['total'] = df['quantity'] * df['price']

total_sales_df = df.groupby('branch')['total'].sum().reset_index()

total_sales_df.to_csv('total_sales_per_branch.csv', index=False)

print("Data processing complete. Saved to 'total_sales_per_branch.csv'")
