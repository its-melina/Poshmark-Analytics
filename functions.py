import pandas as pd

def remove_outliers_iqr(df, col):
    q1 = df[col].quantile(0.25)
    q3 = df[col].quantile(0.75)
    iqr = q3 - q1

    lower = q1 - 1.5*iqr
    upper = q3 + 1.5*iqr

    filtered_df = df[(df[col] >= lower) & (df[col] <= upper)]
    return filtered_df