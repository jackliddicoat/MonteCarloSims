import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import yfinance as yf
from statsmodels.tsa.holtwinters import ExponentialSmoothing

# Load the Microsoft Stock dataset
ticker = 'SPY'
df = yf.download(ticker, start='2022-01-01')
print(df.head())

# Create a series of the 'Close' column
ts = df['Adj Close']

# Create the ES model with smoothing_level=0.6 and smoothing_slope=0.2
model = ExponentialSmoothing(ts, trend="add", seasonal="add", seasonal_periods=12)
model_fit = model.fit()

# Make a prediction for the next 30 days
forecast = model_fit.forecast(steps=30)

print(forecast)

# Plot the historical and predicted data
plt.plot(ts.index, ts, label='Historical Data')
plt.plot(pd.date_range(start=ts.index[-1], periods=31, freq='D')[1:], forecast, label='Predicted Data')
plt.xlabel('Date')
plt.ylabel('Price (USD)')
plt.title(ticker + ' Stock Price Prediction with Exponential Smoothing')
plt.xticks(rotation = 45)
plt.legend()
plt.show()