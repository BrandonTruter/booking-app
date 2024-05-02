require 'rails_helper'

RSpec.describe "Entities", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/entities"
      expect(response).to have_http_status(:success)
    end
  end
end
