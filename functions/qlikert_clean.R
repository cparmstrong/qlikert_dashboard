

#' @param DATA
#' @param NATEXT

#' @return a data frame

#' @importFrom tidyr gather spread
#' @importFrom dplyr select group_by summarize filter mutate
#' @importFrom stringr str_detect str_extract

# tidyr   (>=0.8.2), gather, spread
# dplyr   (>=0.7.8), select, group_by, summarize, filter, mutate
# stringr (>=1.3.1), str_detect, str_extract



## qlikert_clean
qlikert_clean <- function(
  DATA,
  NATEXT = "heythisisaterriblemethodclay",
  RESP_LEVELS = c("Strongly Disagree","Disagree", "Neutral", "Agree", "Strongly Agree")) {
  temp <- DATA %>%
    select(names(DATA)[str_detect(names(DATA), "Q")]) %>%
    gather(contains("Q"), key="q_subq", value="responses", na.rm=TRUE) %>%
    group_by(q_subq, responses) %>%
    summarize(count = n()) %>%
    filter(responses != NATEXT) %>%  # FIGURE OUT HOW TO CONDITIONALLY PIPE
    mutate(subq = gsub(".*_", "", q_subq),
           q = gsub("_.*", "", q_subq),
           freq = count/sum(count),
           question = str_extract(q_subq, "Q\\d*"),
           barlabs = ifelse(freq>=0.05,
                            paste0(100*(round(freq, 2)), "%"),
                            "+"),
           responses = factor(responses,
                              levels = RESP_LEVELS),
           q_subq_text = q_subq)
  assign("dat_scale",
         temp,
         envir = .GlobalEnv)
}




# # this is how it ran with recode/recode_template included; 
# # removed it on 25jan2019 to make it simpler & just work with 5pt likert
# # only modified "responses" and "q_subq_text" parts
# mutate(responses = factor(recode(responses, !!!response_labels),
#                           levels = resp_levels),
#        q_subq_text = recode(q_subq, !!!question_labels))