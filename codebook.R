library(dplyr)
xyz<-data.frame(mean_std_cols)
xyz$mean_std_cols<-as.character(xyz$mean_std_cols) 
  
xyz <- xyz %>% 
        mutate(length_var=nchar(mean_std_cols))