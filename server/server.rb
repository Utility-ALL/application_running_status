require 'sinatra'
require "sinatra/activerecord"
require 'json'

# set :database, {adapter: "sqlite3", database: "foo.sqlite3"}
set :database_file, "config/database.yml"
class AddMachine <  ActiveRecord::Base
end


class App < Sinatra::Base
  set :views => File.dirname(__dir__)+'/client/htmls'

  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
  
  get '/', :provides => 'html' do
    #$json_return={"id":$id}
    $application_details = AddMachine.all
    erb :'index.html'
  end

  get '/delete/:id', :provides => 'html' do
    AddMachine.find(params[:id]).destroy
    redirect '/'
  end

  get '/add', :provides => 'html' do
    erb :'add.html'
  end

  def save(params)
    AddMachine.create(params)
    puts "Params: #{$application_details}"
  end

  def cameraUpdate(params)
  $ip_address = params[:ip_address]
  $proto = params[:proto]
  $port = params[:port]
  respond_to do |format|
    format.html
    format.js
  end
 end

  get '/update_logs' do
    cameraUpdate(params)
  end

  get '/save' do
    save(params)
    redirect '/'
  end
end
