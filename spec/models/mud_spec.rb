require 'rails_helper'

RSpec.describe Mud, type: :model do
  it { is_expected.to have_many(:wikis) }
  
  describe 'url attribute' do
    it 'is valid with a valid url' do
      mud = build(:mud, url: "http://google.com")
      expect(mud).to be_valid
    end
    
    it "isn't valid with an invalid url" do
      mud = build(:mud, url: "not a valid url")
      expect(mud).to_not be_valid
    end
  end
end
