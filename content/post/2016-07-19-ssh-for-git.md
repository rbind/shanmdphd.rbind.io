---
layout: post
title: Github에서 ssh 설정 회복하기
categories: 
share: true
comments: true
tag: [Git, SSH, Data Science]
---

어떤 이유에서인지 몰라도 갑자기 `git push`할때마다 ID와 PW를 입력하라는 메세지를 발견하였습니다.

검색을 해보니 SSH 설정을 새롭게 해보라는 설명이 있어 다음과 같이 시도하였습니다.

```shell
ls -al ~/.ssh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_rsa
```

이렇게 설정한 후부터는 아무런 문제 없이 `git push`를 ID, PW 입력 없이 가능하게 되었습니다.

https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent

