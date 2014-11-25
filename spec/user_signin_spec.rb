require_relative "helpers_sign"

feature "User tries to sign in" do

	include SignIn
	
	before(:each) do
		User.create(:name=>"test",
					:email=>"test@test.com",
					:username=>"test",
					:password=>"test",
					:password_confirmation=>"test")
	end

	scenario "with the correct credentials" do
		visit('/')
		expect(page).not_to have_content("Welcome, Test")
		sign_in("test@test.com", "test")
		expect(page).to have_content("Welcome, Test")
	end

	scenario "with incorrect credentials" do
		visit('/')
		sign_in("m@m.com", "wrong")
		expect(page).to have_content("Your email or password was incorrect")
	end

		scenario "forgets password and uses an email that exists" do
			forgets_password("test@test.com")
			expect(page).to have_content("Your password token was sent to your email address")
		end

		scenario "forgets password and uses an email which doesn't exist" do
			forgets_password("wrong@wrong.com")
			expect(page).to have_content("Please enter a valid email address")
		end

		# scenario "resets password with valid token" do
		# 	visit('/reset_password/1234')
		# 	fill_in(:"new password", :with=>"1")
		# 	fill_in(:"confirm new password", :with=>"1")
		# 	click_button("submit")
		# 	expect(page).to have_content("Please sign in")
		# 	sign_in("test@test.com",'1')
		# 	expect(page).to have_content("Welcome, Test")
		# end

		# scenario "tries to reset password with a token that isn't valid" do
		# 	visit('/reset_password/1')
		# 	expect(page).to have_content("Your token isn't valid")
		# end

end