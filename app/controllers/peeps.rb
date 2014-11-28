post "/addpeep" do
	Peep.create(:text=>params[:"Write a peep"],:user_id=>session[:user_id])
	redirect('/')
end