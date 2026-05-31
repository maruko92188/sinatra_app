# メモアプリ
`Ruby`のフレームワークである`Sinatra`を用いたメモアプリ

## 使用技術
| 言語・フレームワーク | バージョン |
|:--------:|:----------:|
|   Ruby   |    4.0.2   |
|  Sinatra |    4.2.1   |

## 環境構築
1. 開発マシンの任意のディレクトリで`git clone`を行う。
```
$ git clone -b develop-db https://github.com/maruko92188/sinatra_app.git
```
2. `sinatra_app`ディレクトリへ移動する。
```
$ cd sinatra_app
```
3. `gem`をインストールする。
```
$ bundle install
```
4. データベースを準備する
4-1. `PostgreSQL`のインストール
```
$ brew install postgresql
```
4-2. データベースの起動
```
brew services start postgresql@~
```
@~はインストールされているバージョンを指定
バージョンの確認は
```
$ psql --version
``
4-3. データベースの初期設定
```
$ bundle exec ruby setup_db.rb
```
5. サーバーを起動させる
```
$ bundle exec ruby memo_app.rb
```
6. `http://localhost:4567`にアクセスする。
