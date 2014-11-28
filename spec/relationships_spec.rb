require_relative 'spec_helper'


describe "Relationship between peeps and users" do
	
	scenario "a peep must belong to a user" do
		user = User.create(:name=>"test",
					:email=>"test@test.com",
					:username=>"test",
					:password=>"test",
					:password_confirmation=>"test")
		peep = Peep.create(:text=>"hello", :user_id=> user.id)
		expect(peep.user_id).to eq(user.id)
	end

end