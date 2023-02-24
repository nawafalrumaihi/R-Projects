library(ggplot2)

# Read data from .csv file
data <- read.csv("Bahrain SST Temperature 07-17.csv", header = TRUE)

# Plot the data
ggplot(data, aes(x = Locations, y = Temperature)) +
  geom_line(color = "red") +
  labs(title = "Bahrain SST Temperature 07-17", x = "", y = "Temperature (C)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot as .png file
ggplot("Bahrain SST Temperature 07-17.png", width = 20, height = 40, dpi = 200)

