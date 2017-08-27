---
title: MacOS에서 rjava 문제
author: ~
date: '2017-08-26'
slug: macos-rjava
categories: [R]
tags: [R]
banner: 'http://younggates.com/files/editor/462456_ee8d_3.jpg'
description: ''
images: []
menu: ''
---

새로 산 iMac의 MacOS에서 `ReporteRs`를 사용하려고 했더니 `rjava`의 문제가 일어났습니다.

<!--more-->

다음과 같은 명령어를 zsh 터미널에서 입력하면 해결 가능합니다.

```
brew cask install java
brew cask info java
sudo R CMD javareconf
sudo ln -f -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /usr/local/lib 
brew install cairo
```

{{< tweet 895741807933259776 >}}

**출처**

- <http://www.lonecpluspluscoder.com/2017/04/27/installing-java-8-jdk-os-x-using-homebrew>
- <https://stackoverflow.com/questions/30738974/rjava-load-error-in-rstudio-r-after-upgrading-to-osx-yosemite>
