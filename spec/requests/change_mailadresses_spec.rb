require 'rails_helper'

RSpec.describe "ChangeMailadresses", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/change_mailadresses/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
