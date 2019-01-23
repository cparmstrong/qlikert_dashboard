
# qlikert_recode: make file for question/response label replacement          
qlikert_recode_template <- function(UNIQUE_Q = unique(dat_scale$q_subq),
                                    UNIQUE_R = unique(dat_scale$responses),
                                    DIR = getwd()) {
  # make two data files which each contain all the unique question and answer codes
  
  # path should be to the folder directory where output is to be placed
  # gave unique vectors a default value which works in conjunction with qualt likerts
  # getwd() is the default path, you can then easily move them elsewhere
  write.csv(UNIQUE_Q, paste0(DIR, 
                             "/question_labels.csv"), 
            row.names = FALSE)
  write.csv(UNIQUE_R, paste0(DIR, 
                             "/response_labels.csv"), 
            row.names = FALSE)
}

