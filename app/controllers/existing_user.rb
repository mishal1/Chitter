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