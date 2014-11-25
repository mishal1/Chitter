require_relative "helpers_sign"

feature "User signs in" do

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
		expect(page).not_to have_content("Welcome, Mishal")
		sign_in("m@m.com", "wrong")
		expect(page).not_to have_content("Welcome, Mishal")
		expect(page).to have_content("Your email or password was incorrect")
	end

end