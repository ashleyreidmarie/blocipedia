require 'rails_helper'

RSpec.describe PagePolicy do

  subject { described_class }

  describe ".scope" do
    let(:user) { create(:user) }
    
    #create wiki objects
    let(:owned_public_wiki) { create(:wiki, user: user) }
    let(:unowned_public_wiki) { create(:wiki) }
    let(:owned_private_wiki) { create(:wiki, user: user, private: true) }
    let(:unowned_private_wiki) { create(:wiki, private: true) }
    
    #create page objects
    let(:page_public_owned) { create(:page, wiki: owned_public_wiki) }
    let(:page_public_unowned) { create(:page, wiki: unowned_public_wiki) }
    let(:page_private_owned) { create(:page, wiki: owned_private_wiki) }
    let(:page_private_unowned) { create(:page, wiki: unowned_private_wiki) }
    
    
    describe "guest user" do
      it "returns only pages from public wikis" do
        pages = PagePolicy::Scope.new(nil, Page).resolve
        expect(pages).to include(page_public_owned, page_public_unowned)
        expect(pages).to_not include(page_private_owned, page_private_unowned)
      end
    end
    
    describe "standard and premium user" do
      it "returns only pages from public wikis or owned private wikis" do
        pages = PagePolicy::Scope.new(user, Page).resolve
        expect(pages).to include(page_public_owned, page_public_unowned, page_private_owned)
        expect(pages).to_not include(page_private_unowned)
      end
    end
    
    describe "admin user" do
      before {user.admin!}
      
      it "returns all pages" do
        pages = PagePolicy::Scope.new(user, Page).resolve
        expect(pages).to include(page_public_owned, page_public_unowned, page_private_owned, page_private_unowned)
      end
    end
    
  end
end
