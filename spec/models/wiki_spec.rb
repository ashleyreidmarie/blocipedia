require 'rails_helper'

RSpec.describe Wiki, type: :model do
    let(:user) { create(:user) }
    let(:wiki) { create(:wiki, user: user) }
  
    describe "attributes" do
     it "should have name and email attributes" do
       expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: wiki.user, private: wiki.private)
     end
    end
  
end
