require 'rails_helper'

RSpec.describe "Reminders", type: :request do
  describe "GET /create" do
    it "returns http success" do
      pending "add some examples (or delete) #{__FILE__}"
      get "/reminders/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    pending "add some examples (or delete) #{__FILE__}"
    it "returns http success" do
      get "/reminders/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    pending "add some examples (or delete) #{__FILE__}"
    it "returns http success" do
      get "/reminders/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
