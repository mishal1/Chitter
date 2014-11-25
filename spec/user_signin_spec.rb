feature "User signs in" do
	
	before(:each) do
		User.create(:name=>"test",
					:email=>"test@test.com",
					:username=>"test",
					:password=>"test",
					:password_confirmation=>"test")
	end

	def sign_in(email, password)
		visit('/signin')
		fill_in('email', :with=>email)
		fill_in('password', :with=>password)
		click_button("Sign in")
	end

	scenario "with the correct credentials" do
		visit('/')
		expect(page).not_to have_content("Welcome, Mishal")
		sign_in('m@m.com', "test")
		expect(page).to have_content("Welcome, Mishal")
	end

	scenario "with incorrect credentials" do
		visit('/')
		expect(page).not_to have_content("Welcome, Mishal")
		sign_in("m@m.com", "wrong")
		expect(page).not_to have_content("Welcome, Mishal")
		expect(page).to have_content("Your email or password was incorrect")
	end

end