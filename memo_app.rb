# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

# メモアプリ本体

JSON_FILE = './memo.json'

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

