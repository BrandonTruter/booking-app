require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/diaries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/diaries/show"
      expect(response).to have_http_status(:success)
    end
  end

end
