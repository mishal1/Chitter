require 'spec_helper'

feature "User signs up" do

	def sign_up
		visit('/signup')
		expect(page.status_code).to eq(200)
		fill_in :name, :with=> 'bob'
		fill_in :email, :with=> 'bob12@bob.com'
		fill_in :username, :with=>'bob12'
		fill_in :password, :with=> '1'
	end
	

	scenario "with their passwords matching" do
		sign_up
		fill_in :password_confirmation, :with=> '1'
		expect{click_button("Sign me up!")}.to change{User.count}.by(1)
	end

	scenario "with their passwords not matching" do
		sign_up
		fill_in :password_confirmation, :with=>'wrong'
		expect{click_button("Sign me up!")}.to change{User.count}.by(0)
		expect(current_path).to eq("/signup")
		expect(page).to have_content("Sorry, your passwords don't match")

	end

end