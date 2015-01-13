#bowerのインストールとライブラリ追加

```.sh
brew install node

# 一応全部で使えるように(古くなったらすぐに更新する→機能がすぐ追加されるため)
npm install bower -g

mkdir admin && cd admin
bower init
bower install jquery --save-dev
bower install bootstrap --save-dev
```
