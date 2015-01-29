# ENV
OS     : MacYosemite || CentOS6
rbenv  : 0.4.0
Ruby   : 2.0.0 || 2.2.0
Rails  : 4.2.0
powder : 0.3.0

# rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
source ~/.bash_profile
{$OS}
## MacはRuby2.0なので特に理由がなければ入れない
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

# Xcode Command-Line tools
xcode-select --install

# Powder
sudo gem install bundler
sudo gem install powder
sudo gem install rails
