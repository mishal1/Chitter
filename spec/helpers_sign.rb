module SignIn

	def sign_in(email, password)
		click_button 'Sign in'
		fill_in('email', :with=>email)
		fill_in('password', :with=>password)
		click_button("Sign in")
	end

	def sign_up_password_is(password)
		visit('/signup')
		expect(page.status_code).to eq(200)
		fill_in :name, :with=> 'bob'
		fill_in :email, :with=> 'bob12@bob.com'
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

end