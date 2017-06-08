---
layout: post
title: R package 만드는 법
categories: 
share: true
comments: true
tag: [R]
output:
  html_document:
    keep_md: yes
---

R 패키지를 만드는 법은 처음에 참 어렵지만 몇번 해 보면 익숙해집니다.

이 자료들을 읽으면 누구나 만들 수 있습니다.

![](http://r-pkgs.had.co.nz/cover.png)

- [Hadley's Book](http://r-pkgs.had.co.nz/)

![](https://hilaryparker.files.wordpress.com/2014/10/cropped-img_20140902_1804591.jpg)

- [Hilary의 포스팅](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/)

![](https://pbs.twimg.com/profile_images/680796333460959232/CzoFZb76_400x400.jpg)

- [Broman의 웹페이지](http://kbroman.org/pkg_primer/)

간략한 CLI 명령어는 다음과 같습니다.

```bash
R CMD check MyPac_0.0.1
R CMD check --as-cran MyPac_0.0.1
R CMD build MyPac_0.0.1
R CMD rd2pdf MyPac_0.0.1
```

K. Broman의 roxygen2의 설명을 읽으면 좀 더 쉽게 Rd 파일을 만들 수 있습니다.

