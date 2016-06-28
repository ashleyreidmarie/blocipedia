require 'rails_helper'

RSpec.describe Wiki, type: :model do
    let(:user) { create(:user) }
    let(:wiki) { create(:wiki, user: user) }
  
    describe "attributes" do
     it "should have name and description attributes" do
       expect(wiki).to have_attributes(name: wiki.name, description: wiki.description, user: wiki.user, private: wiki.private)
     end
    end
  
end
