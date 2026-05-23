import requests
import pandas as pd


def get_universities(country_keyword):
    url = f"http://universities.hipolabs.com/search?country={country_keyword}"

    try:
        response = requests.get(url)
        response.raise_for_status()  
        data = response.json()
        return data
    except requests.exceptions.RequestException as e:
        print(f"Error While Fetching API: {e}")
        return []


def process_university_data(country_name):
    print(f"Getting the data from: '{country_name}'...")
    raw_data = get_universities(country_name)

    if not raw_data:
        print("No data found")
        return

    df_raw = pd.DataFrame(raw_data)

    df_selected = df_raw[
        ["name", "web_pages", "country", "domains", "state-province"]
    ].copy()

    df_selected.columns = [
        "Name",
        "Web pages",
        "Country",
        "Domains",
        "State Province",
    ]

    print(f"\n[INFO] The total of the data that firstly found: {len(df_selected)} line")

    df_selected["State Province"] = df_selected["State Province"].replace(
        "", None
    )

    df_filtered = df_selected.dropna(subset=["State Province"]).reset_index(
        drop=True
    )

    print(
        f"[INFO] The total the data after filtering data that doesn't contain 'state province': {len(df_filtered)} line\n"
    )
    

    print("=== Sampel Tabel From Filtering ===")
    print(df_filtered.head(10).to_string())



if __name__ == "__main__":
    # parameter 'search_country' dapat diganti dengan negara yang ingin di cari
    search_country = "Canada"
    process_university_data(search_country)