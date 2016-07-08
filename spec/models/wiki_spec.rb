require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user) }
  let(:mud) {create(:mud) }
  let(:wiki) { create(:wiki, user: user, mud: mud) }

  #Validation testing
  it { is_expected.to belong_to(:mud) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:pages) }
  
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:mud) }
  
  it { is_expected.to validate_length_of(:name).is_at_least(3) }
  it { is_expected.to validate_length_of(:description).is_at_least(5) }
  
  it { is_expected.to validate_uniqueness_of(:name) }
  
  describe "attributes" do
   it "should have name and description attributes" do
     expect(wiki).to have_attributes(name: wiki.name, description: wiki.description, private: wiki.private)
   end
  end
    
  
end
