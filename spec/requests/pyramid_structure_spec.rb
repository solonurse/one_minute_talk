require 'rails_helper'

RSpec.describe "PyramidStructures", type: :request do
  describe "GET /update" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/pyramid_structure/update"
      expect(response).to have_http_status(:success)
    end
  end
end
