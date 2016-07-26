require 'rails_helper'

RSpec.describe MudsController, type: :controller do
  let(:user) {create(:user) }
  let(:mud) {create(:mud) }
  let(:wiki) { create(:wiki, mud: mud, user: user) }

  context "guest user" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "GET #show" do
      it "returns http success" do
        get :show, {id: mud.id}
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
        post :create, mud: {name: Faker::Name.first_name, url: Faker::Internet.url}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, {id: mud.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_name = Faker::Name.first_name
        new_url = Faker::Internet.url

        put :update, id: mud.id, mud: {name: new_name, url: new_url }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, {id: mud.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "GET dashboard" do
      it "returns http redirect" do
        get :dashboard
        expect(response).to redirect_to(new_user_session_path)
      end
      
    end
  end
 
  context "logged in user" do
    before { sign_in(user) }

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET #show" do
      it "returns http success" do
        get :show, id: mud.id
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
        post :create,  mud: {name: Faker::Name.first_name, url: Faker::Internet.url}
        expect(response).to redirect_to(muds_path)
      end

      it "increases the number of muds by 1" do
        expect{ post :create, mud: {name: Faker::Name.first_name, url: Faker::Internet.url} }.to change(Mud,:count).by(1)
      end
    end
  
    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: mud.id
        expect(response).to have_http_status(:success)
      end
    end
    
    describe "PUT update" do
      it "returns http redirect" do
        new_name = Faker::Name.first_name
        new_url = Faker::Internet.url

        put :update, id: mud.id, mud: {name: new_name, url: new_url}
        expect(response).to redirect_to(mud_path(id: mud.id))
      end
    end    
    
    describe "DELETE destroy" do
      describe "wiki is still assgined" do
        it "flashes alert notice" do
          mud.wikis.create!(name: Faker::Name.first_name, description: Faker::Hipster.paragraph, user: create(:user))
          delete :destroy, {id: mud.id}
          expect(controller).to set_flash[:alert]
        end
      end
      
      describe "there are no wikis assigned" do
        it "returns http redirect" do
          delete :destroy, {id: mud.id}
          expect(response).to redirect_to(dashboard_muds_path)
        end
  
        it "removes the MUD" do
          delete :destroy, {id: mud.id}
          expect(Mud.count).to eq(0)
        end
      end
    end   
    
    describe "GET dashboard" do
      it "returns http success" do
        get :dashboard
        expect(response).to have_http_status(:success)
      end
      
    end    
    
  end
  
  context "admin user" do
    before { sign_in(user) }
    
    describe "GET dashboard" do
      it "returns http success" do
        get :dashboard
        expect(response).to have_http_status(:success)
      end
      
      it "sets value of muds to all muds" do
        get :dashboard
        expect(assigns(:muds)).to eq(Mud.all)
      end
      
    end
    
  end
  
  context "all users" do
    describe "GET #show" do
      it "redirects when attempting to view unapproved mud" do
        unapproved_mud = Mud.create!(name: Faker::Name.first_name, url: Faker::Internet.url, approved: false)
        get :show, {id: unapproved_mud.id}
        expect(response).to redirect_to(muds_path)
      end
    end
  end
  
end
