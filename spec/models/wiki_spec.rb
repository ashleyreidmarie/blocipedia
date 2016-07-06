require 'rails_helper'

RSpec.describe Wiki, type: :model do
    let(:user) { create(:user) }
    let(:mud) {create(:mud) }
    let(:wiki) { create(:wiki, user: user, mud: mud) }
  
    #Validation testing
    it { is_expected.to belong_to(:mud) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:pages) }
    
    describe "attributes" do
     it "should have name and description attributes" do
       expect(wiki).to have_attributes(name: wiki.name, description: wiki.description, private: wiki.private)
     end
    end
  
end
