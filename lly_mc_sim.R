library(quantmod)

getSymbols("LLY", from = "2023-06-01") # get the symbol
start_price <- last(LLY$LLY.Close)[[1]] # start at the latest day
forecast <- 120 # forecast 4 months
sims <- 30 # number of sims
mean_return <- mean(dailyReturn(LLY)) # mean returns
sd_return <- sd(dailyReturn(LLY)) # sd returns

return_sim <- 1+rnorm(forecast, mean_return, sd_return)
price_sim <- cumprod(c(start_price, return_sim))
plot.ts(price_sim, ylim = c(500, 1500), main = "LLY MC Price Sim")
for (i in 1:20) {
  return_sim <- 1+rnorm(forecast, mean_return, sd_return)
  price_sim <- cumprod(c(start_price, return_sim))
  lines(price_sim, col = i)
}


