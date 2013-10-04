# sprout-wrap

[![Build Status](https://travis-ci.org/pivotal-sprout/sprout-wrap.png?branch=master)](https://travis-ci.org/pivotal-sprout/sprout-wrap)

Prepares a Mac running OS X Mountain Lion for Ruby development using [soloist](https://github.com/mkocher/soloist) and [Sprout](https://github.com/pivotal-sprout/sprout)

## Installation

### 1. Install XCode

[![Xcode - Apple](http://r.mzstatic.com/images/web/linkmaker/badge_macappstore-lrg.gif)](https://itunes.apple.com/us/app/xcode/id497799835?mt=12&uo=4)

### 2. Install Command Line Tools
  
  XCode > Preferences > Downloads
  
### 3. Clone this project
  
    git clone https://github.com/tsnow/sprout-wrap.git
    cd sprout-wrap
  
### 4. Install soloist & and other required gems

    sudo gem install bundler
    bundle

### 4.001. (Optional) Switch to rvm, if you know what's good for you

``` yaml
## In ./soloistrc
recipes:
- tm::osx_base
- tm::osx_development
#- pivotal_workstation::rbenv
- pivotal_workstation::rvm
- tm::ruby_development
node_attributes:
  mysql_root_password: ""
```

### 5. Run soloist
  
    bundle exec soloist
