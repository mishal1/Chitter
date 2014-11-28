require_relative "helpers_sign"
require_relative 'spec_helper'

feature "User signs up" do

	include Helper

	scenario "with their passwords matching" do
		
		expect{sign_up("right")}.to change{User.count}.by(1)
	end

	scenario "with their passwords not matching" do
		expect{sign_up("wrong")}.to change{User.count}.by(0)
		expect(page).to have_content("Sorry, your passwords don't match")

	end

	scenario "with an email that is already registered" do
		create_user
		expect{sign_up("right")}.to change{User.count}.by(0)
		expect(page).to have_content("This email is already taken")
	end

end