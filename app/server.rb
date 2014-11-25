require 'sinatra'
require 'sinatra/partial'
require 'rack-flash'
require_relative './helpers/current'
require_relative './data_mapper_setup'


set :partial_template_engine, :erb
set :public_folder, Proc.new { File.join(root, '.', 'public') }

enable :sessions
set :session_secret, 'super secret'

use Rack::Flash

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

get '/signin' do
	erb :signin
end

post "/signin" do
	email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
	if user
		session[:user_id] = user.id
		redirect ('/')
	else
		flash.now[:notice]= "Your email or password was incorrect"
		erb :signin
	end
end

delete '/signout' do
  session[:user_id]=nil
  flash[:notice]="Goodbye!"
  redirect('/')
end

#Add a view that if the user is already signed in they see logout button instead of the sign in form