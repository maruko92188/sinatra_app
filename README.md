# メモアプリ
`Ruby`のフレームワークである`Sinatra`を用いたメモアプリ

## 使用技術
| 言語・フレームワーク | バージョン |
|:--------:|:----------:|
|   Ruby   |    4.0.2   |
|  Sinatra |    4.2.1   |

## 環境構築
### 開発マシンの任意のディレクトリで`git clone`を行う。
```
git clone -b develop-db https://github.com/maruko92188/sinatra_app.git
```
### `sinatra_app`ディレクトリへ移動する。
```
cd sinatra_app
```
### `gem`をインストールする。
```
bundle install
```
### データベースを準備する
#### `PostgreSQL`のインストール
```
brew install postgresql
```
#### データベースの起動
```
brew services start postgresql@~
```
※ @~はインストールされているバージョンを指定する。バージョンの確認は、
```
psql --version
```
#### データベースの初期設定
```
bundle exec ruby setup_db.rb
```
### サーバーを起動させる
```
bundle exec ruby memo_app.rb
```
### `http://localhost:4567`にアクセスする。
