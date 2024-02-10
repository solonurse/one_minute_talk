require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "GET /create" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/bookmarks/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/bookmarks/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
