require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) {create(:user) }
  let(:mud) {create(:mud) }

  context "guest user" do
    let(:wiki) { create(:wiki) }
    
    describe "GET #show" do
      it "returns http success" do
        get :show, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "GET #new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {name: Faker::Name.first_name, description: Faker::Hipster.paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, {id: wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "PUT #update" do
      it "returns http redirect" do
        new_name = Faker::Name.first_name
        new_description = Faker::Hipster.paragraph

        put :update, id: wiki.id, wiki: {name: new_name, description: new_description }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "DELETE #destroy" do
      it "returns http redirect" do
        delete :destroy, {id: wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  context "Standard role user" do
    before { sign_in(user) }
    let(:owned_wiki) { create(:wiki, mud: mud, user: user) }
    let(:unowned_wiki) { create(:wiki) }
    
    describe "GET #show" do
      it "returns http success" do
        get :show, {id: unowned_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end    
  
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {name: Faker::Name.first_name, description: Faker::Hipster.paragraph, mud_id: mud.id}
        expect(response).to redirect_to(wiki_path(id: Wiki.last.id))
      end

      it "increases the number of wikis by 1" do
        expect{ post :create, wiki: {name: Faker::Name.first_name, description: Faker::Hipster.paragraph, mud_id: mud.id} }.to change(Wiki,:count).by(1)
      end
    end
  
    describe "GET #edit" do
      describe "whene editing an their own wiki" do
        it "returns http success" do
          get :edit, {id: owned_wiki.id}
          expect(response).to have_http_status(:success)
        end
      end
      
      describe "when editing a wiki they don't own" do
        it "returns http redirect" do
          get :edit, {id: unowned_wiki.id}
          expect(response).to have_http_status(302)
        end
      end
    end
    
    describe "PUT #update" do
      describe "wiki user owns" do

        it "returns http redirect to wiki#show view" do
          put :update, id: owned_wiki.id, wiki: {name: Faker::Name.first_name, description: Faker::Hipster.paragraph, mud: mud}
          expect(response).to redirect_to(wiki_path(id: owned_wiki.id))
        end
      end
      
      describe "wiki user does not own" do
        it "returns http redirect" do
          put :update, id: unowned_wiki.id, wiki: {name: Faker::Name.first_name, description: Faker::Hipster.paragraph, mud: mud}
          expect(response).to have_http_status(302)
        end
      end
    end
    
    describe "DELETE destroy" do
      describe "wiki user owns" do
        it "returns http redirect to muds#index" do
          delete :destroy, {id: owned_wiki.id}
          expect(response).to redirect_to(owned_wiki.mud)
        end

        it "removes the wiki" do
          delete :destroy, {id: owned_wiki.id}
          expect(Wiki.count).to eq(0)
        end
      end
      
      describe "wiki user does not own" do
        it "returns http redirect" do
          delete :destroy, {id: unowned_wiki.id}
          expect(response).to have_http_status(302)
        end
      end
    end
    
  end
  
  context "Admin role user CRUD on unowned wiki" do
    before {
      user.admin!
      sign_in(user) }
      
    let(:unowned_wiki) { create(:wiki) }
  
    describe "GET #edit" do
      it "returns http success" do
        get :edit, {id: unowned_wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "PUT #update" do
      it "returns http redirect to wiki#show view" do
        put :update, id: unowned_wiki.id, wiki: {name: Faker::Name.first_name, description: Faker::Hipster.paragraph, mud: mud}
        expect(response).to redirect_to(wiki_path(id: unowned_wiki.id))
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect to muds#index" do
        delete :destroy, {id: unowned_wiki.id}
        expect(response).to redirect_to(unowned_wiki.mud)
      end

      it "removes the wiki" do
        delete :destroy, {id: unowned_wiki.id}
        expect(Wiki.count).to eq(0)
      end
    end
    
  end  
end