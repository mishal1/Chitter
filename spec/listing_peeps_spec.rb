require 'spec_helper'
require_relative "helpers_sign"

feature "User sees peeps" do

	include SignIn

	scenario "when visiting the homepage, see peeps" do
		Peep.create(:text =>"hello!", :user_id=>1)
		visit ('/')
		expect(page).to have_content("hello!")
	end

	scenario "when signed in a user should be able to write a peep" do
		visit('/')
		User.create(:name=>"test",
					:email=>"test@test.com",
					:username=>"test",
					:password=>"test",
					:password_confirmation=>"test")
		sign_in("test@test.com", "test")
		expect(Peep.count).to eq(0)
		expect(page).to have_field("Write a peep")
		add_peep("hello")
		expect(Peep.count).to eq(1)
		expect(page).to have_content("hello")
	end

	scenario "when a user is not signed in they should not be able to write a peep" do
		visit('/')
		expect(page).not_to have_field("Write a peep")
	end

end