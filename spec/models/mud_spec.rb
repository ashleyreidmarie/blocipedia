require 'rails_helper'

RSpec.describe Mud, type: :model do
  
  #Validation testing
  it { is_expected.to have_many(:wikis) }
  
  # describe 'url attribute' do
  #   it 'is valid with a valid url' do
  #     mud = build(:mud, url: "http://google.com")
  #     expect(mud).to be_valid
  #   end
    
  #   it "isn't valid with an invalid url" do
  #     mud = build(:mud, url: "not a valid url")
  #     expect(mud).to_not be_valid
  #   end
  # end
  
  context "scopes" do
    before do
      @unapproved_mud = create(:mud)
      @approved_mud = create(:mud, name: Faker::App.name, approved: true)
    end
    
    describe "approved" do
      it "returns only approved MUDs" do
        expect(Mud.approved).to eq([@approved_mud])
      end
    end
    
    describe "unapproved" do
      it "returns only unapproved MUDs" do
        expect(Mud.unapproved).to eq([@unapproved_mud])
      end
    end
    
  end
  
end
