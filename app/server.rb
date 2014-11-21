require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require_relative './models/peep'
DataMapper.finalize
DataMapper.auto_upgrade!

set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '.', 'public') }

get '/' do
  @peeps = Peep.all
  erb :index
end