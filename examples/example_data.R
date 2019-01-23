sample_from <- rep(c("Strongly Agree", 
                     "Agree", 
                     "Neutral", 
                     "Disagree", 
                     "Strongly Disagree", 
                     "Unsure", 
                     NA),
                   10000)

example_data <- data.frame(
  RespondID = 9780001:9781000,
  Q1        = sample(sample_from, 1000),
  Q2        = sample(sample_from, 1000),
  Q3_1      = sample(sample_from, 1000),
  Q3_2      = sample(sample_from, 1000),
  Q3_3      = sample(sample_from, 1000)
)


example_cols3 <- c('#edf8b1','#7fcdbb','#2c7fb8')
example_cols4 <- c('#ffffcc','#a1dab4','#41b6c4','#225ea8')
example_cols5 <- c('#ffffcc','#a1dab4','#41b6c4','#2c7fb8','#2556b6')


# # install.packages("devtools")
# devtools::install_github("ropensci/qualtRics")
# # jhuedu.co1.qualtrics.com