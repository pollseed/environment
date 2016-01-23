# Install xcode command line tools.
# zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install caskroom/cask/brew-cask

# anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.zshrc
'eval "$(anyenv init -)"' >> ~/.zshrc

# Ruby
anyenv install rbenv
rbenv install 2.3.0
rbenv global 2.3.0
rbenv rehash

# Java
anyenv install jenv
brew cask install java
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home
jenv global oracle64-1.8.0.72

