require 'spec_helper'
require_relative "helpers_sign"

feature "User sees peeps" do

	include Helper

	scenario "when visiting the homepage, see peeps" do
		create_user
		Peep.create(:text =>"hello!", :user_id=>1)
		visit ('/')
		expect(page).to have_content("test(test) => hello")
	end

	scenario "when signed in a user should be able to write a peep" do
		visit('/')
		create_user
		sign_in("test@test.com", "test")
		expect{add_peep("hello")}.to change{Peep.count}.from(0).to(1)
		expect(page).to have_content("test(test) => hello")
	end

	scenario "when a user is not signed in they should not be able to write a peep" do
		visit('/')
		expect(page).not_to have_field("Write a peep")
	end

end