library(ggplot2)

df = read.csv("Bahrain SST Temperature 07-17.csv")
#view(df)

# filter out any values that are equal to 0

filtered_data <- filter(df, df$Temperature != 0)

# create a histogram
histogram <- ggplot(df, aes(x=df$Temperature)) +
  ggtitle("Histogram of Observed SST around Bahrain from 2007 to 2017") +
  labs(x='Temperatures') +
  geom_vline(aes(xintercept=mean(df$Temperature), size = 0.5, alpha = 0.3)) +
  geom_histogram(alpha = 0.5, color = 'black', fill = 'white') 

plot(histogram)