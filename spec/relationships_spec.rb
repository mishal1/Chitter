require_relative 'spec_helper'
require_relative "helpers_sign"


describe "Relationship between peeps and users" do
	include Helper
	
	scenario "a peep must belong to a user" do
		user = create_user
		peep = Peep.create(:text=>"hello", :user_id=> user.id)
		expect(peep.user_id).to eq(user.id)
	end

end