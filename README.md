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
$ git clone -b develop https://github.com/maruko92188/sinatra_app_JSON.git
```
2. `sinatra_app_JSON`ディレクトリへ移動する。
```
$ cd sinatra_app_JSON
```
3. `gem`をインストールする。
```
$ bundle install
```
4. サーバーを起動させる。
```
$ bundle exec ruby memo_app.rb
```
5. `http://localhost:4567`にアクセスする。
