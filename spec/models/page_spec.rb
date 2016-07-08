require 'rails_helper'

RSpec.describe Page, type: :model do
    let(:user) { create(:user) }
    let(:mud)  { create(:mud) }
    let(:wiki) { create(:wiki, user: user, mud: mud) }
    let(:page) { create(:page, wiki: wiki) }
    
    describe "attributes" do
       it "should have title and body attributes" do 
          expect(page). to have_attributes(title: page.title, body: page.body) 
       end
    end
end