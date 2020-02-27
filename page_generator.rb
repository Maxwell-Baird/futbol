require 'sinatra'

get '/' do
  erb :index
end

get '/home_stats' do
  erb :home_stats
end
