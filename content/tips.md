---
date: 2017-06-01
title: Tips
menu: 'main'
tags: [R, Bash, Git]
---

> Here I present some random R, Git, Bash tips and tricks I have learned from various resources. (Stackoverflow, Google, Wikia etc)

# R

#### switch

If value is a character vector then the element of ‘...’ with a name that exactly matches value is evaluated. If there is no match a single unnamed argument will be used as a default. If no default is specified, NULL is returned.

```r
> y <- "fruit"
> switch(y, fruit = "banana", vegetable = "broccoli", "Neither")
[1] "banana"
> y <- "meat"
> switch(y, fruit = "banana", vegetable = "broccoli", "Neither")
[1] "Neither"
A common use of switch is to branch according to the character value of one of the arguments to a function.

> centre <- function(x, type) {
+ switch(type,
+        mean = mean(x),
+        median = median(x),
+        trimmed = mean(x, trim = .1))
+ }
> x <- rcauchy(10)
> centre(x, "mean")
[1] 0.8760325
> centre(x, "median")
[1] 0.5360891
> centre(x, "trimmed")
[1] 0.6086504
```

Reference: [R language definition](https://cran.r-project.org/doc/manuals/r-release/R-lang.html#switch)
#### stars.pval {gtools}

This will convert p-value to stars (\*).

```r
stars.pval <- function (p.value) {
    unclass(symnum(p.value, corr = FALSE, na = FALSE, cutpoints = c(0, 
        0.001, 0.01, 0.05, 0.1, 1), symbols = c("***", "**", 
        "*", ".", " ")))
}
```

#### identifying os

```r
get_os <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  tolower(os)
}
```

Reference: [conjugateprior.org](http://conjugateprior.org/2015/06/identifying-the-os-from-r/)



#### math styles in R plots

```r
demo(plotmath)
```

#### Converting a matrix of characters into numeric

```r
mat <- matrix(c("5","6","7","8","hello","world"),ncol=3)
class(mat) <- "numeric"
```

---

# Git

##### Reducing size

```bash
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now
```

Reference: [npteam](https://www.npteam.net/954)

##### Github open

```bash
# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi
 
  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl$branch
  open $giturl
}
```


##### Git initializing

```bash
echo "# REPONAME" >> README.md
git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/shanmdphd/REPONAME.git
git push -u origin master
```

##### .gitignore

**Ignore 되어야 하지만 이미 add된 파일 표시**

```bash
git ls-files -ci --exclude-standard
```

**Ignore 되어야 하지만 이미 add된 파일을 GIT에서 제거 (파일 자체는 남겨둠.)**

```bash
git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached
```

##### Syncing a fork

```bash
git remote add --track master upstream https://github.com/mmistakes/so-simple-theme.git
git fetch upstream
git merge upstream/master --allow-unrelated-histories
git checkout --ours README.md
git checkout --theirs README.md
```

Reference: [Dogfeet](http://dogfeet.github.io/)

##### Diagram

![](http://cfile7.uf.tistory.com/image/161305504DBE8DD22BBD45)

Reference: [bunhere.tistory.com](http://bunhere.tistory.com/37)

##### In case of fire
![](https://hikaruzone.files.wordpress.com/2015/10/in-case-of-fire-1-git-commit-2-git-push-3-leave-building2.png?w=1200)

---

# Bash

##### Convert PDF to PNG - multiple files

```bash
for file in *_PK_Model_DV_vs_PRED.pdf; do
    convert -density 300 "$file" "${file%.pdf}.png"
done
```

##### Replace string across directories

```bash
grep -rl 'NonCompart' * | xargs sed -i '' -e 's/NonCompart/ncar/g'
```

##### Lazygit : git add, commit, push for lazy people like me. 

Copy & paste this lines to your `~/.bash_profile`

```bash
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
```

```bash
lazygit "Update README.md"
```

---

# Vim

##### find all the word 'foo' where there is no 'bar' following, we can do:

```vim
/foo\(.*bar\)\@!
```

Reference: [Wikia](http://vim.wikia.com/wiki/Search_for_lines_not_containing_pattern#Using_the_:v_command)

##### Word count

```vim
%s/[^ ]\+//gn
```

Reference: [Wikia](http://vim.wikia.com/wiki/Word_count)

##### Title case

```vim
s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g
```

Reference: [Wikia](http://vim.wikia.com/wiki/Switching_case_of_characters)

##### Quote

**줄의 앞뒤로 따옴표 붙이기**

```vim
%s/^\(.*\)$/"\1"/
```

```vim
%s/.*/"&"
```

**줄의 맨 뒤로 따옴표 붙이기**

```vim
%s/^\(.*\)$/\1"/
```

**Bash**

```vim
cat foo.txt | sed s/^\(.*\)$/"\1"/g
```

Reference: [Stackoverflow](http://stackoverflow.com/questions/3218789/adding-characters-at-the-start-and-end-of-each-line-in-a-file)

##### Markdown 에서 bullet 맨 앞에 대문자로

```vim
:%s/\(- [a-z]\)/\U\1/
```

Reference: [Wikia](http://vim.wikia.com/wiki/Changing_case_with_regular_expressions)

# VB

##### Repeat Header Row in Word

```
Sub RepeatTableHeadings()

  Dim tbl As Table

  For Each tbl In ActiveDocument.Tables
    tbl.Rows(1).HeadingFormat = True
  Next tbl

End Sub
```

Reference: [BeyondVBA](http://vba.relief.jp/word-macro-repeat-table-headings/)

##### Image resize

```
Sub resize()
Dim i As Long
With ActiveDocument
    For i = 1 To .InlineShapes.Count
        With .InlineShapes(i)
            .ScaleHeight = 24
            .ScaleWidth = 24
        End With
    Next i
End With
End Sub
```

Reference: [superuser](http://superuser.com/questions/940771/how-can-i-resize-multiple-images-in-a-ms-word-document)

