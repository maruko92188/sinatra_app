# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

JSON_FILE = './memo.json'
FIRST_ID = 1

get '/' do 
  redirect '/memos'
end

get '/memos' do
  memos = load_memos(JSON_FILE)
  erb :index, locals: { memos: }
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memos = load_memos(JSON_FILE)
  posted_memos = post_memos(memos, params)
  save_memos(JSON_FILE, posted_memos)

  redirect '/memos'
end

get '/memos/:id' do
  memos = load_memos(JSON_FILE)
  memo = find_memo(memos, params)
  erb :detail, locals: {id: params[:id], memo: }
end

get '/memos/:id/edit' do
  memos = load_memos(JSON_FILE)
  memo = find_memo(memos, params)
  erb :edit, locals: {id: params[:id], memo: }
end

patch '/memos/:id' do
  memos = load_memos(JSON_FILE)
  patched_memos = patch_memos(memos, params)
  save_memos(JSON_FILE, memos)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = load_memos(JSON_FILE)
  id = params[:id]
  memos.delete(id)
  save_memos(JSON_FILE, memos)
  redirect '/memos'
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
  memos.fetch(id)
end

def post_memos(memos, params)
  id = memos.keys.map(&:to_i).max&.next || FIRST_ID
  title = params[:title]
  content = params[:content]
  memos[id] = { title:, content:, }
  memos
end

def patch_memos(memos, params)
  id = params[:id]
  title = params[:title]
  content = params[:content]
  memos[id] = { title:, content: }
  memos
end
