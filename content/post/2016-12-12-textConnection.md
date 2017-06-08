---
layout: post
title: R에서 텍스트를 파일처럼 읽는 법 - textConnection
categories: 
share: true
comments: true
tag: [R]
---


R에서 텍스트를 파일처럼 읽는 법을 고민하다가 드디어 해결책을 찾았습니다.

textConnection을 사용하면 가능합니다.

Data dictionary 내에 coding되어 있는 파일을 decoding할때 유용히 사용할 수 있을 것 같습니다.

``` R
library(dplyr)
Dictionary <- data.frame(content = "1, Test\\n2,Ref", last = "3", stringsAsFactors = FALSE)
Original <- data.frame(Code = c(1, 2, 1, 2, 2), name = c("A", "B", "C", "A", "B"))
Coding <- read.csv(textConnection(A$content), header = FALSE, col.names = c("Code", "Decode"))
```


```r
library(dplyr)
Dictionary <- data.frame(content = "1, Test\\n2,Ref", last = "3", stringsAsFactors = FALSE)
Original <- data.frame(Code = c(1, 2, 1, 2, 2), name = c("A", "B", "C", "A", "B"))
Coding <- read.csv(textConnection(A$content), header = FALSE, col.names = c("Code", "Decode"))
```


``` r
library(dplyr)
Dictionary <- data.frame(content = "1, Test\\n2,Ref", last = "3", stringsAsFactors = FALSE)
Original <- data.frame(Code = c(1, 2, 1, 2, 2), name = c("A", "B", "C", "A", "B"))
Coding <- read.csv(textConnection(A$content), header = FALSE, col.names = c("Code", "Decode"))
```

```R
library(dplyr)
Dictionary <- data.frame(content = "1, Test\\n2,Ref", last = "3", stringsAsFactors = FALSE)
Original <- data.frame(Code = c(1, 2, 1, 2, 2), name = c("A", "B", "C", "A", "B"))
Coding <- read.csv(textConnection(A$content), header = FALSE, col.names = c("Code", "Decode"))
```

