require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) {create(:user) }
  let(:mud) {create(:mud) }
  let(:wiki) { create(:wiki, mud: mud, user: user) }
  let(:page) { create(:page, wiki: wiki) }


  context "guest user" do
    describe "GET #index" do
      it "returns http success" do
        get :index, wiki_id: wiki.id
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "GET #show" do
      it "returns http success" do
        get :show, {wiki_id: wiki.id, id: page.id}
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "GET #new" do
      it "returns http redirect" do
        get :new, {wiki_id: wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki_id: wiki.id, page: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, wiki_id: wiki.id, id: page.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, wiki_id: wiki.id, id: page.id, page: {name: new_title, description: new_body }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, wiki_id: wiki.id, id: page.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  context "logged in user" do
    login_user
  
    describe "GET #index" do
      it "returns http success" do
        get :index, wiki_id: wiki.id
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "GET #show" do
      it "returns http success" do
        get :show, {wiki_id: wiki.id, id: page.id}
        expect(response).to have_http_status(:success)
      end
    end  
  
    describe "GET #new" do
      it "returns http success" do
        get :new, wiki_id: wiki.id
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki_id: wiki.id, page: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to(wiki_page_path(wiki_id: wiki.id, id: wiki.pages.last.id))
      end

      it "increases the number of pages by 1" do
        expect{ post :create, wiki_id: wiki.id, page: {title: RandomData.random_sentence, body: RandomData.random_paragraph} }.to change(Page,:count).by(1)
      end
    end
  
    describe "GET #edit" do
      it "returns http success" do
        get :edit, {wiki_id: wiki.id, id: page.id}
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_name = RandomData.random_sentence
        new_description = RandomData.random_paragraph

        put :update, wiki_id: wiki.id, id: page.id, page: {title: new_name, body: new_description}
        expect(response).to redirect_to(wiki_page_path(wiki_id: wiki.id, id: page.id))
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, {wiki_id: wiki.id, id: page.id}
        expect(response).to redirect_to(wiki_path)
      end

      it "decreases the number of page by 1" do
        delete :destroy, {wiki_id: wiki.id, id: page.id}
        expect(Page.count).to eq(0)
      end
    end
  end

end
