# setup ----

library(tidyverse)
#install.packages('zoo')
excluded <- '2007-07-06-10-17.md'

yamlformat <- '---
%s
%s
author: ~
#draft: true
categories:
  - personal
tag:
  - personal
---
%s
'

# main ----

old <- tibble(txt = read_lines('data-raw/old-1.txt')) %>% 
  mutate(title = ifelse(c(grepl('share this post', txt)[c(-1, -2)], FALSE, FALSE), txt, NA)) %>% 
  mutate(title = zoo::na.locf(title, na.rm = FALSE)) %>% 
  filter(!is.na(title)) %>% 
  group_by(title) %>% 
  mutate(date = gsub('분류없음 ', '', nth(txt, 2))) %>% 
  mutate(filename = sprintf('%s.md', gsub('[^0-9]', '-', date))) %>% 
  mutate(date = sprintf('date: %s', gsub('\\.', '-', sub(' .*$', '', date)))) %>% 
  ungroup() %>% 
  mutate(title = trimws(gsub('\\[.*\\]', '', title))) %>% 
  mutate(title = ifelse(title == '', 'Thought', title)) %>% 
  mutate(title = sprintf("title: %s", title)) %>% #filter(grepl('Note', title)) %>% 
  select(filename, title, date, txt) %>%
  # simplify date ymd
  group_by(filename, title, date) %>% 
  summarise(content = paste(txt, collapse = '\n')) %>% 
  mutate(content = gsub('.*share this post|신고\nWRITTEN BY.*트랙백이 없고 ,|name.*submit|댓글이 없습니다\\.|prevnext.*\\[sungpilhan\\]', 
                        '\n\n', content)) %>% 
  mutate(content = gsub('(................) 신고   ', '`\\1`: ', content)) %>% 
  mutate(content = gsub('달렸습니다.', '달렸습니다.\n\n- ', content)) %>% 
  mutate(all = sprintf(yamlformat, title, date, content)) %>% 
  filter(!filename %in% excluded) %>% 
  print()

oldblog <- old$filename %>% 
  map(~ write_lines(x = old %>% 
                      filter(filename == .x) %>% 
                      .$all, 
                    path = sprintf('./content/personal/%s', .x)))
oldblog %>% head
# oldblog <- lapply(old$filename, function(x){
#   blog <- old %>%
#     filter(filename == x) %>% 
#     .$all
#   write_lines(blog, sprintf('./content/personal/%s', x))
# })

