require 'rails_helper'

RSpec.describe WikiPolicy do

  let(:user) { create(:user) }

  describe "scope" do
    let(:public_wiki) { create(:wiki, private: false) }
    let(:unowned_private_wiki) { create(:wiki, private: true) }
    let(:owned_private_wiki) { create(:wiki, user: user, private: true) }
    
    context "regular users" do
      it "returns public wikis and private wikis owned by the user" do
        
        expect(WikiPolicy::Scope.new(user, Wiki).resolve).to include(public_wiki, owned_private_wiki)
        expect(WikiPolicy::Scope.new(user, Wiki).resolve).to_not include(unowned_private_wiki)
      end
    end
    
    context "admin users" do
      before { user.admin! }
      
      it "returns all wikis" do
        expect(WikiPolicy::Scope.new(user, Wiki).resolve).to include(public_wiki, owned_private_wiki, unowned_private_wiki)
      end
    end
  end
end
