
# setup ----

library(tidyverse)

# main ----

install.packages('zoo')

tibble(txt = read_lines('drafts/old.txt')) %>% 
  mutate(title = ifelse(c(grepl('share this post', txt)[c(-1, -2)], FALSE, FALSE), txt, NA)) %>% 
  mutate(title = zoo::na.locf(title, na.rm = FALSE)) %>% 
  filter(!is.na(title)) %>% 
  mutate(title = sprintf("title: '%s'", title)) %>% 
  group_by(title) %>% 
  mutate(date = gsub('분류없음 ', '', nth(txt, 2))) %>% 
  mutate(filename = sprintf('%s.md', gsub('[^0-9]', '-', date))) %>% 
  select(filename, title, date, txt) %>% 
  # simplify date ymd
  mutate(date = sprintf('date: %s', gsub('\\.', '-', sub(' .*$', '', date)))) %>% 
  View

