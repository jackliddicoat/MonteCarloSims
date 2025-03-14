# packages needed
library(quantmod)
library(ggplot2)
library(lubridate)
library(dplyr)

yoy_stock_performance <- function(symbol, start_date) {
  stock <- getSymbols(symbol, src ="yahoo", from = start_date, auto.assign = F)
  stock <- data.frame(stock)
  dates <- rownames(stock)
  df <- data.frame("close_price" = stock[,4])
  df$date <- as.Date(dates)
  rownames(df) <- seq(1, nrow(df), 1)
  
  df %>% 
    select(close_price, date) %>% 
    mutate(year = year(date)) %>% 
    group_by(year) %>% 
    reframe(change = close_price/first(close_price) - 1, 
            date = yday(date)) %>%
    ggplot(aes(date, change, group = year,
               color = year == max(year))) +
    geom_line(show.legend = F) +
    scale_color_manual(values = c('lightgrey', "blue")) +
    scale_y_continuous(labels = scales::percent_format()) +
    labs(y = "Change YTD",
         title = paste0(symbol, " Performance by Year"),
         subtitle = "Data from Yahoo, colored line is current year",
         x = "# Day of year") +
    geom_hline(yintercept = 0, lty = 2) +
    theme_light() +
    theme(plot.title = element_text(face = "bold"))
}

yoy_stock_performance("NVDA", start = "2000-01-01")
