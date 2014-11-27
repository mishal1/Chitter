post "/addpeep" do
	Peep.create(:text=>params[:"Write a peep"])
end