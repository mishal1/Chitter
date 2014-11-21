require 'spec_helper'

feature "User sees peeps" do
	
	before(:each) {
		Peep.create(:text => "hello!")
	}

	scenario "when visiting the homepage, see peeps" do
		visit ('/')
		expect(page).to have_content("hello!")
	end

end