require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'



env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require_relative './models/peep'
require_relative './models/user'
DataMapper.finalize
DataMapper.auto_upgrade!

set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '.', 'public') }

enable :sessions
set :session_secret, 'super secret'

use Rack::Flash
use Rack::MethodOverride

get '/' do
  @peeps = Peep.all
  erb :index
end

get '/signup' do
	@user = User.new
	erb :signup
end

post '/signup' do
	@user = User.create(:name => params[:name],
				:email => params[:email],
				:username => params[:username],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect('/')
	else
		flash.now[:errors]=@user.errors.full_messages
		erb :signup
	end
end

helpers do

	def current_user
		@current_user ||=User.get(session[:user_id]) if session[:user_id]
	end

end