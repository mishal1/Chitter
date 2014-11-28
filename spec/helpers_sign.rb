module Helper

	def sign_in(email, password)
		click_button 'Sign in'
		fill_in('email', :with=>email)
		fill_in('password', :with=>password)
		click_button("Sign in")
	end

	def sign_up(password)
		visit('/')
		click_button('Sign up')
		fill_in :name, :with=> 'bob'
		fill_in :email, :with=> 'test@test.com'
		fill_in :username, :with=>'bob12'
		fill_in :password, :with=> 'right'
		fill_in :password_confirmation, :with=> password
		click_button("Sign me up!")
	end

	def forgets_password(email)
		visit('/')
		click_button('Sign in')
		click_link('Forgot password?')
		expect(page).to have_content("Please enter your email")
		fill_in :email, :with=>email
		click_button("Submit")
	end

	def add_peep(text)
		fill_in 'Write a peep', :with=>text
		click_button "Submit peep"
	end

	def create_user
		User.create(:name=>"test",
					:email=>"test@test.com",
					:username=>"test",
					:password=>"test",
					:password_confirmation=>"test")
	end

end