

qlikert_order <- function(
                 QNUMS, 
                 DATA = dat_scale, 
                 POS_RESPONSE = c("Agree", "Strongly Agree"), 
                 TYPE = "agree") {
  temp <- DATA %>%
    filter(q %in% QNUMS)
  
  # aggregate
  agg <- temp %>%
    filter(responses %in% POS_RESPONSE)  %>%
    group_by(q_subq) %>%
    summarize(positive = sum(freq))
  
  # agg$q_subq <- paste0(agg$q, "_", agg$subq)
  temp <- merge(temp, agg, by = c("q_subq"))
 
  # commented out assignment 25jan2019 
  assign(paste0("dat_scale_", TYPE),
   temp,
   envir = .GlobalEnv)
  
  # ADD FUNCTIONALITY FOR alternative SORT METHODs
}





# # this works 25jan2019
# # modifying becuase "Error: `fun` must return a single number per group" in shiny app
# qlikert_order <- function(
#   QNUMS, 
#   DATA = dat_scale, 
#   POS_RESPONSE = c("Agree", "Strongly Agree"), 
#   TYPE = "agree") {
#   temp <- DATA %>%
#     filter(q %in% QNUMS)
#   
#   # aggregate
#   agg <- temp %>%
#     filter(responses %in% POS_RESPONSE)  %>%
#     group_by(subq, q) %>%
#     summarize(positive = sum(freq))
#   
#   agg$q_subq <- paste0(agg$q, "_", agg$subq)
#   temp <- merge(temp, agg, by = c("q_subq", "q", "subq"))
#   
#   assign(paste0("dat_scale_", TYPE),
#          temp,
#          envir = .GlobalEnv)
#   
#   # ADD FUNCTIONALITY FOR OTHER SORT METHOD
# }
