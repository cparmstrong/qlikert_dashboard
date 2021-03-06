set.seed(8282017)


sample_from <- rep(c("Strongly Agree", 
                     "Agree", 
                     "Neutral", 
                     "Disagree", 
                     "Strongly Disagree", 
                     "Unsure", 
                     NA),
                   100)

example_data <- data.frame(
  RespondID = 978001:978100,
  Q1        = sample(sample_from, 100),
  Q2        = sample(sample_from, 100),
  Q3_1      = sample(sample_from, 100),
  Q3_2      = sample(sample_from, 100),
  Q3_3      = sample(sample_from, 100),
  Q4        = sample(sample_from, 100),
  Q5        = sample(sample_from, 100),
  Q6_1      = sample(sample_from, 100),
  Q6_2      = sample(sample_from, 100),
  Q6_3      = sample(sample_from, 100),
  Q6_4      = sample(sample_from, 100),
  Q6_5      = sample(sample_from, 100),
  Q6_7      = sample(sample_from, 100)
)

# clay_cols <- list(
  # cols3 = c('#edf8b1','#7fcdbb','#2c7fb8')
  # cols4 = c('#ffffcc','#a1dab4','#41b6c4','#225ea8')
cols5 = c('#ffffcc','#a1dab4','#41b6c4','#2c7fb8','#2556b6', '#444444')  # grayscale for unsure
# )

# library(dplyr)
# library(forcats)
# library(ggplot2)
# library(stringr)
# library(tidyr)

# # install.packages("devtools")
# devtools::install_github("ropensci/qualtRics")
# # jhuedu.co1.qualtrics.com


  # playing with colors
library(ggplot2)
temp <- example_data[!example_data$Q1 %in% c("Unsure", NA), ]
test_cols <- c("#002d72", "#68ace5", "#86c8bc", "#719949", "#286140")
test_cols <- c("#002d72", "#68ace5", "#a192b2", "#cf4520", "#76232f")

ggplot(data = temp) +
  geom_bar(aes(x = Q1,
               fill = Q1),
           position = position_stack()) +
  scale_fill_manual(values = rev(test_cols)) + 
  coord_flip()


# custom color for client