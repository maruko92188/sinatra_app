# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

JSON_FILE = './memo.json'
FIRST_ID = 1

set :show_exceptions, false

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

before '/memos/?*' do
  @memos = load_memos(JSON_FILE)
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  posted_memos = post_memos(@memos, params)
  save_memos(JSON_FILE, posted_memos)

  redirect '/memos'
end

get '/memos/:id' do
  memo = find_memo(@memos, params)
  erb :detail, locals: { id: params[:id], memo: }
end

get '/memos/:id/edit' do
  memo = find_memo(@memos, params)
  erb :edit, locals: { id: params[:id], memo: }
end

patch '/memos/:id' do
  patched_memos = patch_memos(@memos, params)
  save_memos(JSON_FILE, patched_memos)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  deleted_memos = delete_memos(@memos, params)
  save_memos(JSON_FILE, deleted_memos)

  redirect '/memos'
end

not_found do
  erb :not_found, layout: false
end

def load_memos(path)
  if File.exist?(path)
    JSON.parse(File.read(path))
  else
    {}
  end
end

def save_memos(path, memos)
  File.open(path, 'w') { |file| JSON.dump(memos, file) }
end

def find_memo(memos, params)
  id = params[:id]
  memos.fetch(id) do
    halt 404
  end
end

def post_memos(memos, params)
  id = memos.keys.map(&:to_i).max&.next || FIRST_ID
  title = params[:title]
  content = params[:content]
  memos[id] = { title:, content: }
  memos
end

def patch_memos(memos, params)
  id = params[:id]
  title = params[:title]
  content = params[:content]
  memos[id] = { title:, content: }
  memos
end

def delete_memos(memos, params)
  id = params[:id]
  memos.delete(id)
  memos
end
