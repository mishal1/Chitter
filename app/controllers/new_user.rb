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