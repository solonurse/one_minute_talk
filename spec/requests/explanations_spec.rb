require 'rails_helper'

RSpec.describe "Explanations", type: :request do
  describe "GET /element" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/explanations/element"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /basis" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/explanations/basis"
      expect(response).to have_http_status(:success)
    end
  end
end
