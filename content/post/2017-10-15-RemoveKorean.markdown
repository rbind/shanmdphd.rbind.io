---
date: 2017-10-15
title: '글자 타입에서 한글 없애기'
categories: [R]
tags: [R, Data Science]
---

가끔 R에서 한글로 된 문자를 모두 없애고 싶을 때가 있습니다. 다음과 같은 정규표현식을 사용해서 제거할 수 있습니다.


```r
# 한글없애기
RemoveKorean <- function(data){
  gsub("\\p{Hangul}+", "-", data, perl=TRUE)
}

# 2017-10-15 Daum.net Headline
Text <- '국민연금 연기하면 이득?75세돼야 겨우 9만원 / 홍준표 "文정부 들어 아내 통신조회 4차례"'

# 실행
RemoveKorean(Text)
```

[1] "- - -?75- - 9- / - \"文- - - - 4-\""
