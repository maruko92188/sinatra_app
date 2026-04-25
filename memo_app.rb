# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

# メモアプリ本体

JSON_FILE = './memo.json'
FIRST_ID = 1

get '/' do 
  redirect '/memos'
end

get '/memos' do
  memos =
  if File.exist?(JSON_FILE)
    JSON.parse(File.read(JSON_FILE))
  else
    {}
  end
  erb :index, locals: { memos: }
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memos = 
  if File.exist?(JSON_FILE)
    JSON.parse(File.read(JSON_FILE))
  else
    {}
  end
  title = params[:title]
  content = params[:content]
  id = memos.keys.map(&:to_i).max&.next || FIRST_ID
  memos[id] = { title:, content:, }
  File.open(JSON_FILE, 'w') { |file| JSON.dump(memos, file) }

  redirect '/memos'
end

get '/memos/:id' do
  memos =
  if File.exist?(JSON_FILE)
    JSON.parse(File.read(JSON_FILE))
  else
    {}
  end
  id = params[:id]
  title = memos[id]['title']
  content = memos[id]['content']
  erb :detail, locals: { title:, content: }
end
