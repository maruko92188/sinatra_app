# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'config/db_config'

set :show_exceptions, false

configure do
  set :conn, PG.connect(dbname: DATABASE_NAME)
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  memos = settings.conn.exec("SELECT id, title FROM #{TABLE_NAME} ORDER BY id DESC;").to_a
  erb :index, locals: { memos: }
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  post_memos(params[:title], params[:content])

  redirect '/memos'
end

get '/memos/:id' do
  memo = find_memo(params[:id])
  erb :detail, locals: { memo: }
end

get '/memos/:id/edit' do
  memo = find_memo(params[:id])
  erb :edit, locals: { memo: }
end

patch '/memos/:id' do
  patch_memos(params[:id], params[:title], params[:content])

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete_memos(params[:id])

  redirect '/memos'
end

not_found do
  erb :not_found, layout: false
end

def find_memo(id)
  halt 404 unless id =~ /\A\d+\z/
  settings.conn.exec_params("SELECT * FROM #{TABLE_NAME} WHERE id = $1 LIMIT 1;", [id]).first || halt(404)
end

def post_memos(title, content)
  settings.conn.exec_params("INSERT INTO #{TABLE_NAME} (title, content) VALUES ($1, $2);", [title, content])
end

def patch_memos(id, title, content)
  settings.conn.exec_params("UPDATE #{TABLE_NAME} SET title = $1, content = $2 WHERE id = $3;", [title, content, id])
end

def delete_memos(id)
  settings.conn.exec_params("DELETE FROM #{TABLE_NAME} WHERE id = $1;", [id])
end
