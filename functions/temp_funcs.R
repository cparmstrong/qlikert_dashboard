



qlikert_order <- function(
                 DATA, 
                 QNUMS, 
                 POS_RESPONSE = c(), 
                 TYPE = "agree") {
  temp <- DATA %>%
    filter(q %in% QNUMS)
  
  # aggregate
  agg <- temp %>%
    filter(responses %in% POS_RESPONSE)  %>%
    group_by(subq, q) %>%
    summarize(positive = sum(freq))
  
  agg$q_subq <- paste0(agg$q, "_", agg$subq)
  temp <- merge(temp, agg, by = c("q_subq", "q", "subq"))
  
  assign(paste0("dat_scale_", TYPE),
   temp,
   envir = .GlobalEnv)
  
  # ADD FUNCTIONALITY FOR OTHER SORT METHOD
}








