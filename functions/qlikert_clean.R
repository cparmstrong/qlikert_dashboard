
## qlikert_clean
qlikert_clean <- function(
  DATA, 
  NATEXT = "heythisisaterriblemethodclay") {
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
           responses = factor(recode(responses, !!!response_labels),
                              levels = resp_levels),
           q_subq_text = recode(q_subq, !!!question_labels))
  
  assign("dat_scale",
         temp, 
         envir = .GlobalEnv)
}