import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import yfinance as yf
from statsmodels.tsa.arima.model import ARIMA
from pandas.plotting import autocorrelation_plot

# Load the Microsoft Stock dataset
ticker = 'SPY'
df = yf.download(ticker, start='2024-01-01')

# Create a series of the 'Close' column
ts = df['Adj Close']

# Create the ARIMA model (5 order lag, 1st differencing, no moving average term)
model = ARIMA(ts, order=(20, 1, 0))
model_fit = model.fit()

# print the summary of the fit
print(model_fit.summary())

# forecast 30 days
forecast = model_fit.forecast(steps = 30)

# Plot the historical and predicted data
plt.plot(ts.index, ts, label='Historical Data')
plt.plot(pd.date_range(start=ts.index[-1], periods=31, freq='D')[1:], forecast, label='Predicted Data')
plt.xlabel('Date')
plt.ylabel('Price (USD)')
plt.title(ticker + ' Stock Price Prediction with ARIMA')
plt.xticks(rotation = 45)
plt.legend()
plt.show()
