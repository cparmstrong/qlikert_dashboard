sample_from <- rep(c("Strongly Agree", 
                     "Agree", 
                     "Neutral", 
                     "Disagree", 
                     "Strongly Disagree", 
                     "Unsure", 
                     NA),
                   10000)

example.data <- data.frame(
  RespondID = 9780001:9781000,
  Q1        = sample(sample_from, 1000),
  Q2        = sample(sample_from, 1000),
  Q3_1      = sample(sample_from, 1000),
  Q3_2      = sample(sample_from, 1000),
  Q3_3      = sample(sample_from, 1000)
)





# # install.packages("devtools")
# devtools::install_github("ropensci/qualtRics")
# # jhuedu.co1.qualtrics.com