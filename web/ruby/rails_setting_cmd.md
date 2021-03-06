# Setting

## sample PJを置いておいた
[sample_pj](https://github.com/pollseed/rails_sample_hoge_develop)

### 手っ取り早く試す
1. [secrets.yml](https://github.com/pollseed/rails_sample_hoge_develop/blob/develop/config/secrets.yml)のsecret_key_baseを入れ込む
2. 以下の環境設定をする
3. 以下のHerokuのコマンド通りにデプロイ  

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
heroku git:remote -a App名

# develop/prodの切り分け
# Gemfile
group :development,:test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

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
  has_many:infos, dependent: :destroy
end
# many to one
class Info < ActiveRecord::Base
  belongs_to:user
end
```

###migration

```.rb
# migrationファイル生成
$ rails generate migration add_index_to_users_name

# index追加の処理を追記
class AddIndexToUsersName < ActiveRecord::Migration
  def change
    add_index :users :name
  end
end

# migrate処理
$ bundle exec rake db:migrate
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
# ダミーデータ挿入
# Gemfile
gem 'faker'

# マスクデータを突っ込む→migrateを参照したくなければ(bundle exec rake db:reset)
$ bundle exec rake db:migrate:reset
$ bundle exec rake db:populate(bundle exec rake db:seed)
```

```.rb
# バリデート
class Hoge < ActiveRecord::Base
  validates:name, length: {maximum:50}
end
```

```.rb
# 省略
[1,2,3,4].map { |i| i.to_s }.join(",")
[1,2,3,4].map(&:to_s).join(",")
```

```.rb
# css framework 適用
bundle exec rake assets:precompile Rails_ENV=development
```

```.rb
# bootstrap's template made
rails g bootstrap:install
rails g bootstrap:layout application
```

```.rb
# use Helper by controller's file(通常はやらない)
# 共通のApplicationHelperにhogeメソッドを作っておく
module ApplicationHelper
  def hoge
    puts("hoge")
  end
end

# 共通のApplicationControllerにApplicationHelperをインクルードしておく
class ApplicationController < ActionController::Base
  include ApplicationHelper
end

# 使いたいコントローラからHelperメソッドを呼び出す
class WelcomeController < ApplicationController
  def index
    hoge
  end
end

# use Model by controller's file
# modelにメソッドをself付きで作っておく
class Hoge < ActiveRecord::Base
  def self.find_by
    Hoge.where(:deleted => false)
  end
end

# 使いたいコントローラからModelメソッドを呼び出す
class WelcomeController < ApplicationController
  def index
    find_by
  end
end

```
