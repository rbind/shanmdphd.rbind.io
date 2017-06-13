library(tidyr)
library(dplyr)
library(tibble)

df <- data.frame(file = dir("md"), tempfile = dir("md"), stringsAsFactors = FALSE)
substring(df$tempfile, 11, 11) <- ":"
dfconv <- as.tibble(df) %>% 
  separate(tempfile, into = c("date", "slug"), sep = ":", remove = FALSE) %>% 
  mutate(slug = gsub(".md", "", slug),
         slug = gsub("_", "-", slug)) %>% 
  group_by(date) %>% 
  mutate(seq = LETTERS[row_number()]) %>% 
  arrange(date, seq) %>% 
  mutate(newfile = paste(date, seq, ".md", sep = "-")) %>% 
  mutate(finalfile = paste(date, slug, sep = "-"))
  
# for (i in 1:nrow(dfconv)){
#   paste0("cp md/", dfconv$file[i], " newmd/", dfconv$newfile[i]) %>% system
# }
# 
# for (i in 1:nrow(dfconv)){
#   paste0("cp newmd/", dfconv$newfile[i], " content/post/", dfconv$finalfile[i], ".md") %>% system
# }
# 
# # rollback
# for (i in 1:nrow(dfconv)){
#   paste0("rm content/post/", dfconv$finalfile[i], ".md") %>% system
# }
# 
for (i in 1:nrow(dfconv)){
  paste0("cp newmd/", dfconv$newfile[i], " content/post/", dfconv$finalfile[i], ".md") %>% system
}
