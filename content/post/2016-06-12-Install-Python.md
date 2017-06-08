---
title: Python development in OSX
layout: post
---

ysyang님의 [이 글](http://wsyang.com/2015/07/19/hellow-python/)을 이대로 따라해보았습니다.
설치환경: OSX 10.11.5 El Capitan

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install pyenv
export PATH="$HOME/.pyenv/shims:$PATH"
pyenv install anaconda3-4.0.0
pyenv rehash
pyenv version
brew install homebrew/boneyard/pyenv-pip-rehash
python --version # 본문에 오타 있었습니다.
pyenv global anaconda3-4.0.0
pyenv rehash
conda update conda

>>> import numpy
>>> numpy.test('full')
>>> import scipy
>>> scipy.test('full')
>>> import matplotlib
>>> matplotlib.test()
```

다만 여기서 에러가 났는데 https://github.com/numpy/numpy/issues/6718 이 글을 참고할 수 있겠습니다.

```
>>> numpy.test('full')
FAIL: test_scripts.test_f2py
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/Users/Sungpil/.pyenv/versions/anaconda3-4.0.0/lib/python3.5/site-packages/nose/case.py", line 198, in runTest
    self.test(*self.arg)
  File "/Users/Sungpil/.pyenv/versions/anaconda3-4.0.0/lib/python3.5/site-packages/numpy/testing/decorators.py", line 146, in skipper_func
    return f(*args, **kwargs)
  File "/Users/Sungpil/.pyenv/versions/anaconda3-4.0.0/lib/python3.5/site-packages/numpy/tests/test_scripts.py", line 82, in test_f2py
    assert_(success, "Warning: neither %s nor %s found in path" % f2py_cmds)
  File "/Users/Sungpil/.pyenv/versions/anaconda3-4.0.0/lib/python3.5/site-packages/numpy/testing/utils.py", line 53, in assert_
    raise AssertionError(smsg)
AssertionError: Warning: neither f2py nor f2py found in path
```

http://tutorial.djangogirls.org/ko/python_introduction/
DjangoGirls의 위 책도 Python을 이해하는데 큰 도움이 될듯.

Programming is a fun!
