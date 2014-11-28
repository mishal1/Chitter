require_relative 'spec_helper'

describe Peep do

	it "should be created and then retrieved from the database" do
		expect{Peep.create(:text => "Hello", :user_id=>1)}.to change{Peep.count}.from(0).to(1)
		peep = Peep.first
		expect(peep.text).to eq('Hello')
		peep.destroy
		expect(Peep.count).to eq(0)
	end
	
end