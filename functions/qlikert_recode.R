# comment out the whole thing 25jan2019 bc otherwise it wont deploy
# 
# # likert graphs: load in file for question/response label replacement
# qlikert_recode <- function(Q_R,
#                            LEVELS = c("Strongly Disagree","Disagree", "Neutral", "Agree", "Strongly Agree"), # VECTOR CONTAINING RESPONSE LEVELS IN ORDER
#                            DIR = getwd()
#                            # RESP_LEVELS,
#                            # QUEST_LABELS = NULL,   
# ){
#   # Q_R: a single letter string indicating whether we're recoding "Q"uestions or "R"esponses
#   # DIR: path to the folder where the labels files are located
#   stopifnot(Q_R %in% c("Q", "R"))
#   if (Q_R == "Q") {
#     temp <- read.csv(paste0(DIR, "/question_labels.csv"))
#     assign("question_labels", 
#            setNames(as.character(temp$X), temp$x),
#            envir = .GlobalEnv)
#   } else if (Q_R == "R") {
#     print("Responses will be out of order if you didn't provide an ordered vector of levels.")
#     temp <- read.csv(paste0(DIR, "/response_labels.csv"))
#     
#     # WHY THESE TWO DIFFERENT?
#     assign("response_labels", 
#            setNames(as.character(temp$X), temp$x),
#            envir = .GlobalEnv)
#     assign("resp_levels",
#            as.factor(c(LEVELS)), 
#            envir = .GlobalEnv)
#   }
# }
# 
# 
# # 
# 
# \