require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }
  let(:page) { create(:page, wiki: wiki) }
  
  describe "GET #index" do
    it "returns http success" do
      get :index, wiki_id: wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, wiki_id: wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, wiki_id: wiki.id, id: page.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, wiki_id: wiki.id, id: page.id
      expect(response).to have_http_status(:success)
    end
  end

end
