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

before do
  next if request.path_info == '/memos/new'
  @memos = load_memos
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
  post_memos(params)

  redirect '/memos'
end

get '/memos/:id' do
  memo = find_memo(params)
  erb :detail, locals: { id: params[:id], memo: }
end

get '/memos/:id/edit' do
  memo = find_memo(params)
  erb :edit, locals: { id: params[:id], memo: }
end

patch '/memos/:id' do
  patch_memos(params)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  delete_memos(params)

  redirect '/memos'
end

not_found do
  erb :not_found, layout: false
end

def load_memos
  if File.exist?(JSON_FILE)
    JSON.parse(File.read(JSON_FILE))
  else
    {}
  end
end

def find_memo(params)
  id = params[:id]
  @memos.fetch(id) do
    halt 404
  end
end

def post_memos(params)
  id = @memos.keys.map(&:to_i).max&.next || FIRST_ID
  title = params[:title]
  content = params[:content]
  @memos[id] = { title:, content: }
  save_memos
end

def patch_memos(params)
  id = params[:id]
  title = params[:title]
  content = params[:content]
  @memos[id] = { title:, content: }
  save_memos
end

def delete_memos(params)
  id = params[:id]
  @memos.delete(id)
  save_memos
end

def save_memos
  File.open(JSON_FILE, 'w') { |file| JSON.dump(@memos, file) }
end
