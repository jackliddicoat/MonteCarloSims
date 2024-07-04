# monte carlo function
# library(quantmod)

monte_carlo <- function(ticker, start_date, forecast_days, sims) {
  xts_ticker <- getSymbols(ticker, from = start_date, auto.assign = F)
  latest_price <- last(xts_ticker[,6])[[1]]
  mean_return <- mean(dailyReturn(xts_ticker))
  sd_return <- sd(dailyReturn(xts_ticker))
  rand_returns <- matrix(nrow = sims, ncol = forecast_days)
  mat <- matrix(nrow = sims, ncol = forecast_days+1)
  mat
  for (i in 1:sims) {
    rand_returns[i,] <- 1 + rnorm(forecast_days, mean_return, sd_return)
    mat[i,] <- cumprod(c(latest_price, rand_returns[i,]))
  }
  final_price <- array(dim = sims, dimnames = NULL)
  for (i in 1:sims) {
    final_price[i] <- (mat[i, forecast_days+1] - mat[i, 1]) / mat[i, 1]
  }
  min <- which.min(final_price)
  med <- match(median(final_price), final_price)
  max <- which.max(final_price)
  plot(mat[med,], type = "l", lty = 1, ylab = "Price ($)", las = 1,
          main = paste("MC Simulation of", ticker),
       ylim = c(min(mat[min,]), max(mat[max,])))
  lines(mat[min,], lty = 2)
  lines(mat[max,], lty = 3)
  legend("topleft", legend = c("Max", "Med", "Min"), lty = c(3, 1, 2))
}

monte_carlo(ticker = "SPY", start_date = "2024-01-01",
            forecast_days = 90, sims = 101)
