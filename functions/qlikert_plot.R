
# 25jan2019 - question text currently not working; i only had it from template as it had to be manually pulled in; need to see if the API will allow me to grab that automatically; would still need to figure out fitting issues

qlikert_plot <- function(QNUM,  
                         COLS = cols5, 
                         DATA = dat_scale_agree,
                         SAVE = FALSE, 
                         WRAP = 40,  # modifying will break legend
                         RESP_LEVELS = resp_levels,
                         GUIDE_ROWS = 1,  # modifying will break legend
                         NAME = QNUM, 
                         DIR = paste0(getwd(), "/likert graphs/"),
                         HEIGHT = 2.5 + ((length(unique(plot_data$q_subq_text)) - 3) / 3),
                         OFFSET = -0.33 + 0.021*length(unique(plot_data$q_subq_text))
) {
  
  plot_data <- DATA %>% filter(question %in% QNUM)
  
  plot <- DATA %>% 
    filter(question %in% QNUM) %>%
    ggplot(aes(x = fct_reorder(str_wrap(q_subq_text, WRAP),
                               positive,
                               .desc = FALSE),
               y = freq, 
               fill = responses,
               label = barlabs)) +
    geom_bar(position = position_stack(reverse = TRUE),
             stat="identity", 
             width=0.75) + 
    geom_text(size = 4, 
              position = position_stack(reverse = TRUE,
                                        vjust = 0.5), 
              family="serif") +
    guides(fill = guide_legend(nrow=GUIDE_ROWS, reverse=FALSE)) +
    scale_fill_manual(values=COLS, name=NULL) +
    scale_y_continuous(labels=scales::percent) +
    labs(x = NULL, y = NULL) +
    theme(panel.background = element_rect(fill="white", color="white"),
          panel.grid.major = element_line(color="grey95"),
          text = element_text(size=11, family="serif"),
          panel.border=element_rect(size=2, color="#000000", fill=NA),
          legend.position = c(0.25, 
                              OFFSET),  # -.13,  # need fix for high subq
          plot.margin = unit(c(20,20,40,20), "pt"), 
          axis.text.y = element_text(hjust=0.5)) +
    coord_flip()
  print(plot)
  if (SAVE == TRUE) {
    ggsave(paste0(DIR, NAME, ".jpg"),
           plot,
           width = 6.5,
           height = if (HEIGHT < 9) {
             HEIGHT
           } else {
             print("Too long for 8.5 x 11 margins. Supply alternative height.")
             
           },
           # height = 2.5 + ((length(unique(plot_data$q_subq_text)) - 3) / 3),
           dpi = 300)
    # print("remember to create graphs folder")
    # set default wrap width based on number of responses
    # flip directions
    # write f(x) function to get legend position from str_wrap (tricky)
    ## height argument may or may not have interplay
    ## adding axis titles will be tough
  }
  # add in functionality to do subsets (district, etc.)
}




# min =  2.5  = 3 bar
# max = 8.83 = 22 bar
# simulate formula for HEIGHT 
# dat <- data.frame(x = 1:22,
#                   y = 2.5 + ((1:22 - 3) / 3))
# plot(dat$x, dat$y)
# 
# # find formula for LEGEND POSITION
# dat <- data.frame(x = c(   3,    8,  22),
#                   y = c(-.23, -.13,   0))  # not stable above ~n=10
# plot(dat)
# (-.13 - (-.23))/(8-3)