require_relative "helpers_sign"

feature 'User signs out' do

	include SignIn

	before(:each) do
		User.create(:name=>"test",
					:email=>"test@test.com",
					:username=>"test",
					:password=>"test",
					:password_confirmation=>"test")
	end

	scenario "while being signed in" do
		visit('/')
		sign_in("test@test.com", "test")
		click_button "Sign out"
		expect(page).to have_content("Goodbye!")
		expect(page).not_to have_content("Welcome, Test")
	end

	scenario "can sign back in after user has been signed out" do
		visit('/')
		sign_in("test@test.com", "test")
		click_button "Sign out"
	end

end