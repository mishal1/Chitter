require 'spec_helper'

feature "User signs up" do

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
	

	scenario "with their passwords matching" do
		
		expect{sign_up_password_is('right')}.to change{User.count}.by(1)
	end

	scenario "with their passwords not matching" do
		expect{sign_up_password_is("wrong")}.to change{User.count}.by(0)
		expect(page).to have_content("Sorry, your passwords don't match")

	end

	scenario "with an email that is already registered" do
		expect{sign_up_password_is("right")}.to change{User.count}.by(1)
		expect{sign_up_password_is("right")}.to change{User.count}.by(0)
		expect(page).to have_content("This email is already taken")
	end

	scenario "with an email that is already registered" do
		expect{sign_up_password_is("right")}.to change{User.count}.by(1)
		expect{sign_up_password_is("right")}.to change{User.count}.by(0)
		expect(page).to have_content("This username is already taken")
	end

end