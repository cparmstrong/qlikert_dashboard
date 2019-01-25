#' Generate Recode Template
#' This function creates templates for the user to edit the labels for questions and answers.
#' path should be to the folder directory where output is to be placed
#' # gave unique vectors a default value which works in conjunction with qualt likerts
#' @UNIQUE_Q extracts the unique questions
#' @UNIQUE_R extracts the unique responses
#' @DIR is the working directory. Defaults to getwd().


#' @importFrom utils write.csv



qlikert_recode_template <- function(
  UNIQUE_Q = unique(dat_scale$q_subq),
  UNIQUE_R = unique(dat_scale$responses),
  DIR = getwd()) {

  write.csv(UNIQUE_Q, paste0(DIR,
                             "/question_labels.csv"),
            row.names = FALSE)
  write.csv(UNIQUE_R, paste0(DIR,
                             "/response_labels.csv"),
            row.names = FALSE)
}
