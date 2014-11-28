get '/forgot_password' do
	erb :forgot_password
end

post '/forgot_password' do
	user = User.first(:email => params[:email])
	if user
		user.update(:password_token => (1..50).map{('A'..'Z').to_a.sample}.join)
		user.save
		erb :sent_email
	else
		flash[:notice]= "Please enter a valid email address"
		redirect('/forgot_password')
	end
end

get '/reset_password/:token' do
	session[:user_token] = params[:token]
	user = User.first(:password_token => params[:token])
	if user
		erb :reset_password
	else
		erb :invalid_token
	end
end

post '/reset_password' do
	user = User.first(:password_token=>session[:user_token])
	user.update(:password=>params[:new_password],
				:password_confirmation=> params[:confirm_password])
	if user.save
		redirect('/signin')
	else
		flash[:notice]="Your passwords don't match"
		redirect("/reset_password/#{session[:user_token]}")
	end
end
