# Setting

## ENV

```
OS     : MacYosemite || CentOS6
rbenv  : 0.4.0
Ruby   : 2.0.0 || 2.2.0
Rails  : 4.2.0
Pow    : 0.5.0
powder : 0.3.0
PaaS   : Heroku
```

## rbenv

```.sh
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
source ~/.bash_profile
{$OS}
### MacはRuby2.0なので特に理由がなければ入れない
rbenv install -l
rbenv install 2.2.0
rbenv global 2.2.0
rbenv rehash
ruby -v

{$OS} <- linux
  yum install gcc make openssl-devel

{$OS} <- mac
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  brew update
  brew install rbenv ruby-build
```

## Xcode Command-Line tools

```.sh
xcode-select --install
```

## Powder

```.sh
curl get.pow.cx | sh
sudo gem install bundler
sudo gem install powder
sudo gem install rails
```

# How To Use

## [Powder](https://github.com/Rodreegez/powder) Hosts Link

```.sh
rails new hoge
cd hoge
powder link
powder open
powder list
```

## [Heroku](https://dashboard.heroku.com/apps) Deploy

```.sh
# install
brew cask install heroku-toolbelt
heroku login
# input for email / password
cd hoge

# create
heroku create

# deploy main
git push heroku master
heroku logs

# rename
heroku rename hoge

# models
heroku run rake db:migrate
heroku restart

# open
heroku open
```

## Develop

###bundle

```
bundle install --without production
bundle update
bundle install
```

###scaffold

```.sh
# Unique id はオート String型ではなくstringなので注意
rails generate scaffold User nickname:string
rails generate scaffold Info name:string email:string
bundle exec rake db:migrate

# create
rails generate controller HogeFuga hoge fuga
rails generate model User nickname:string
bundle exec rake db:migrate

# delete
rails destroy controller HogeFuga hoge fuga
rails destroy model User
bundle exec rake db:rollback or rake db:migrate VERSION=0
```

```.rb
# 外部キーの設定など
# one to many
class User < ActiveRecord::Base
  has_many:infos
end
# many to one
class Info < ActiveRecord::Base
  belongs_to:user
end
```

###tips

```.rb
# ソートして変数に上書き
str = "140,143,150,142".split(",")
str.sort!
str[0..-1]
```

```.java
/* ランダム文字列拝借でJavaとRubyコード量比較 */

  // Javaだと
  public static String getRandomNumber(int length) {
      final String[] _alpha = 
      { "a", "b", "c", "d", "e", "f", "g", "h", "i", 
      "j", "k", "l", "m", "n", "o", "p", "q", "r", 
      "s", "t", "u", "v", "w", "x", "y", "z" };
      List<String> alphaList = Arrays.asList(_alpha);
      Collections.shuffle(alphaList);
      StringBuilder sb = new StringBuilder();
      int i = 0;
      for (String str : (String[]) alphaList.toArray()) {
          if (i >= length)
              break;
          sb.append(str);
          i++;
      }
      return sb.toString();
  }
  
  // Rubyだと
  def getRandomNumber(length)
    ('a'..'z').to_a.shuffle[0..length].join
  end
```

```.rb
# include
1.layouts/_home.html.erbを作成
2.<%= render 'layouts/hoge' %>
```

```.rb
# Gemfile
gem 'faker'

# マスクデータを突っ込む→migrateを参照したくなければ(bundle exec rake db:reset)
$ bundle exec rake db:migrate:reset
$ bundle exec rake db:populate
```
