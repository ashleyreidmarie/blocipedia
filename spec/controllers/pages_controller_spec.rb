require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) {create(:user) }
  let(:wiki) { create(:wiki) }
  let(:page) { create(:page, wiki: wiki) }


  context "guest user" do
    
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
        post :create, wiki_id: wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph}
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
        
        put :update, wiki_id: wiki.id, id: page.id, page: {name: Faker::Commerce.product_name, body: Faker::Hipster.paragraph }
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


  context "standard and premium user" do
    before { sign_in(user) }
    
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
    
    describe "GET #show" do
      describe "pages on public wikis" do
        it "returns http success" do
          get :show, {wiki_id: unowned_public_wiki.id, id: page_public_unowned.id}
          expect(response).to have_http_status(:success)
        end
      end
      describe "pages on private owned wikis" do
        it "returns http success" do
          get :show, {wiki_id: owned_private_wiki.id, id: page_private_owned.id}
          expect(response).to have_http_status(:success)
        end
      end
      describe "pages on private unowned wikis" do
        it "returns http redirect" do
          get :show, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(response).to have_http_status(302)
        end
      end      
    end  
  
    describe "GET #new" do
      describe "for page on public wiki" do
        it "returns http success" do
          get :new, wiki_id: unowned_public_wiki.id
          expect(response).to have_http_status(:success)
        end
      end
      describe "for page on owned private wiki" do
        it "returns http success" do
          get :new, wiki_id: owned_private_wiki.id
          expect(response).to have_http_status(:success)
        end
      end
      describe "for page on unowned private wiki" do
        it "returns http redirect" do
          get :new, wiki_id: unowned_private_wiki.id
          expect(response).to have_http_status(302)
        end
      end
    end
  
    describe "POST #create" do
      describe "for page on public wiki" do
        it "returns http redirect to new page" do
          post :create, wiki_id: unowned_public_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph}
          expect(response).to redirect_to(wiki_page_path(wiki_id: unowned_public_wiki.id, id: unowned_public_wiki.pages.last.id))
        end
  
        it "increases the number of pages by 1" do
          expect{ post :create, wiki_id: unowned_public_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph} }.to change(Page,:count).by(1)
        end
      end
      describe "for page on owned private wiki" do
        it "returns http redirect to new page" do
          post :create, wiki_id: owned_private_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph}
          expect(response).to redirect_to(wiki_page_path(wiki_id: owned_private_wiki.id, id: owned_private_wiki.pages.last.id))
        end
  
        it "increases the number of pages by 1" do
          expect{ post :create, wiki_id: owned_private_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph} }.to change(Page,:count).by(1)
        end
      end
      describe "for page on unowned private wiki" do
        it "returns http redirect" do
          post :create, wiki_id: unowned_private_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph}
          expect(response).to have_http_status(302)
        end
      end
    end
  
    describe "GET #edit" do
      describe "for page on public wiki" do
        it "returns http success" do
          get :edit, {wiki_id: unowned_public_wiki.id, id: page_public_unowned.id}
          expect(response).to have_http_status(:success)
        end
      end
      describe "for page on private owned wiki" do
        it "returns http success" do
          get :edit, {wiki_id: owned_private_wiki.id, id: page_private_owned.id}
          expect(response).to have_http_status(:success)
        end
      end
      describe "for page on private unowned wiki" do
        it "returns http redirect" do
          get :edit, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(response).to have_http_status(302)
        end
      end
    end
    
    describe "PUT update" do
      describe "for page on public wiki" do
        it "returns http redirect to new page" do
          new_name = Faker::Commerce.product_name
          new_body = Faker::Hipster.paragraph
  
          put :update, wiki_id: unowned_public_wiki.id, id: page_public_unowned.id, page: {title: new_name, body: new_body}
          expect(response).to redirect_to(wiki_page_path(wiki_id: unowned_public_wiki.id, id: page_public_unowned.id))
        end
      end
      describe "for page on private unowned wiki" do
        it "returns http redirect" do
          put :update, wiki_id: unowned_private_wiki.id, id: page_private_unowned.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph}
          expect(response).to have_http_status(302)
        end
      end
    end
    
    describe "DELETE destroy" do
      describe "for page on owned public wiki" do 
        it "returns http redirect to wiki" do
          delete :destroy, {wiki_id: owned_public_wiki.id, id: page_public_owned.id}
          expect(response).to redirect_to(wiki_path)
        end
  
        it "decreases the number of page by 1" do
          delete :destroy, {wiki_id: owned_public_wiki.id, id: page_public_owned.id}
          expect(Page.count).to eq(0)
        end
      end
      describe "for page on unowned public wiki" do
        it "returns http redirect" do
          delete :destroy, {wiki_id: unowned_public_wiki.id, id: page_public_unowned.id}
          expect(response).to have_http_status(302)
        end
      end
      describe "for page on unowned private wiki" do
        it "returns http redirect" do
          delete :destroy, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(response).to have_http_status(302)
        end
      end
    end
    
  end
  
  context "admin user" do
    before { 
      user.admin!
      sign_in(user) }
    
    let(:unowned_private_wiki) { create(:wiki, private: true) }
    let(:page_private_unowned) { create(:page, wiki: unowned_private_wiki) }
    
    describe "GET #show" do
      describe "pages on private unowned wikis" do
        it "returns http success" do
          get :show, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(response).to have_http_status(:success)
        end
      end      
    end
    
    describe "GET #new" do
      describe "for page on unowned private wiki" do
        it "returns http success" do
          get :new, wiki_id: unowned_private_wiki.id
          expect(response).to have_http_status(:success)
        end
      end
    end    
    
    describe "POST #create" do
      describe "for page on unowned private wiki" do
        it "returns http redirect to new page" do
          post :create, wiki_id: unowned_private_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph}
          expect(response).to redirect_to(wiki_page_path(wiki_id: unowned_private_wiki.id, id: unowned_private_wiki.pages.last.id))
        end
  
        it "increases the number of pages by 1" do
          expect{ post :create, wiki_id: unowned_private_wiki.id, page: {title: Faker::Commerce.product_name, body: Faker::Hipster.paragraph} }.to change(Page,:count).by(1)
        end
      end
    end

    describe "GET #edit" do
      describe "for page on private unowned wiki" do
        it "returns http success" do
          get :edit, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(response).to have_http_status(:success)
        end
      end
    end
    
    describe "PUT update" do
      describe "for page on private unowned wiki" do
        it "returns http redirect to new page" do
          new_name = Faker::Commerce.product_name
          new_body = Faker::Hipster.paragraph
  
          put :update, wiki_id: unowned_private_wiki.id, id: page_private_unowned.id, page: {title: new_name, body: new_body}
          expect(response).to redirect_to(wiki_page_path(wiki_id: unowned_private_wiki.id, id: page_private_unowned.id))
        end
      end
    end    
    
    describe "DELETE destroy" do
      let(:unowned_public_wiki) { create(:wiki) }
      let(:page_public_unowned) { create(:page, wiki: unowned_public_wiki) }
      
      describe "for page on unowned public wiki" do
        it "returns http redirect to wiki" do
          delete :destroy, {wiki_id: unowned_public_wiki.id, id: page_public_unowned.id}
          expect(response).to redirect_to(wiki_path)
        end
  
        it "decreases the number of page by 1" do
          delete :destroy, {wiki_id: unowned_public_wiki.id, id: page_public_unowned.id}
          expect(Page.count).to eq(0)
        end
      end
      describe "for page on unowned private wiki" do
        it "returns http redirect to wiki" do
          delete :destroy, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(response).to redirect_to(wiki_path)
        end
  
        it "decreases the number of page by 1" do
          delete :destroy, {wiki_id: unowned_private_wiki.id, id: page_private_unowned.id}
          expect(Page.count).to eq(0)
        end
      end
    end    
    
  end

end
