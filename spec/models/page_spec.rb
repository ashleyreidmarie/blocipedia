require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:user) { create(:user) }
  let(:mud)  { create(:mud) }
  let(:wiki) { create(:wiki, user: user, mud: mud) }
  let(:page) { create(:page, wiki: wiki) }
    
      #Validation testing
  it { is_expected.to belong_to(:wiki) }
  
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:wiki) }
  
  it { is_expected.to validate_length_of(:title).is_at_least(3) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }
  
    
  describe "attributes" do
    it "should have title and body attributes" do 
      expect(page). to have_attributes(title: page.title, body: page.body) 
    end
  end
end