require_relative "helpers_sign"
require 'spec_helper'

feature "User signs up" do

	include SignIn

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