library(quantmod)
library(ggplot2)
library(tidyverse)

stock_sim_graph <- function(symbol, days_back, prediction_days) {
  # get the symbols of the stock
  stock <- getSymbols(symbol, from = Sys.Date() - days_back, auto.assign = F)
  stock_df <- data.frame(stock)
  # past prices of the stock
  past_prices <- as.vector(stock_df[,4])
  newest_price <- as.numeric(last(stock_df[,4]))
  
  random_returns <- 1 + rnorm(prediction_days, mean(dailyReturn(stock)),
                          sd(dailyReturn(stock)))
  
  predictions <- newest_price*cumprod(random_returns)
  
  prices <- append(past_prices, predictions)
  colors <- c(rep("black", length(past_prices)), rep("red", length(predictions)))
  df <- data.frame(prices, colors, "time" = seq(1, length(prices), 1))
  
  # past and predicted price
  df %>% 
    ggplot(aes(x = time, y = prices)) +
    geom_line(color = colors, group = 1) +
    labs(title = paste0(prediction_days, "-day prediction for ", symbol))
}

stock_sim_graph("ARES", 200, 30)
