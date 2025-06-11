import pandas as pd
import ast

def clean_data(df):
     # specifying correct datatypes
    df['sold price'] = df['sold price'].str.replace(',','').str.strip('$').astype('Int64')
    df['original price'] = df['original price'].str.replace(',','').str.strip('$').astype('Int64')
    df['nwt'] = df['nwt'].astype('Int64')
    df['boutique'] = df['boutique'].astype('Int64')
    df['sold date'] = pd.to_datetime(df['sold date'], format='%m-%d-%Y', errors='coerce')
    df['post_date'] = pd.to_datetime(df['post_date'], format='%Y-%m-%d', errors='coerce')

    # adding a column indicating how long a listing took to sell
    df['days to sell'] = (df['sold date'] - df['post_date']).dt.days

    # one-hot encoding for colors
    df['color(s)'] = df['color(s)'].str.lower()
    df['color(s)']  = df['color(s)'].apply(lambda x: ast.literal_eval(x) if isinstance(x, str) else x)
    exploded = df.explode('color(s)')
    dummies = pd.get_dummies(exploded['color(s)'])
    ohe_df = dummies.groupby(exploded.index).sum()
    df = df.join(ohe_df)
    return df

def remove_outliers_iqr(df, col):
    q1 = df[col].quantile(0.25)
    q3 = df[col].quantile(0.75)
    iqr = q3 - q1

    lower = q1 - 1.5*iqr
    upper = q3 + 1.5*iqr

    filtered_df = df[(df[col] >= lower) & (df[col] <= upper)]
    return filtered_df