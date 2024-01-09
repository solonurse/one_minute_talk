require 'rails_helper'

RSpec.describe "Explanations", type: :request do
  describe "GET /element" do
    it "returns http success" do
      get "/explanations/element"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /basis" do
    it "returns http success" do
      get "/explanations/basis"
      expect(response).to have_http_status(:success)
    end
  end

end
