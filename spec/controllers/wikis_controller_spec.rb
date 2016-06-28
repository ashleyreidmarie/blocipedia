require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:wiki) { create(:wiki) }

  context "guest user" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
    
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
        post :create, wiki: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: wiki.id, wiki: {name: new_name, description: new_description }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, {id: wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  context "logged in user" do
    login_user
  
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "GET #show" do
      it "returns http success" do
        get :show, {id: wiki.id}
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
        post :create, wiki: {name: RandomData.random_sentence, description: RandomData.random_paragraph}
        expect(response).to redirect_to(wiki_path(id: Wiki.last.id))
      end

      it "increases the number of wikis by 1" do
        expect{ post :create, wiki: {name: RandomData.random_sentence, description: RandomData.random_paragraph} }.to change(Wiki,:count).by(1)
      end
    end
  
    describe "GET #edit" do
      it "returns http success" do
        get :edit, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, id: wiki.id, wiki: {name: new_name, description: new_description}
        expect(response).to redirect_to(wiki_path(id: wiki.id))
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, {id: wiki.id}
        expect(response).to redirect_to(root_path)
      end

      it "decreases the number of wikis by 1" do
        delete :destroy, {id: wiki.id}
        expect(Wiki.count).to eq(0)
      end
    end
    
  end
end