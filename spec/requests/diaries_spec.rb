require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get diaries_path
      expect(response).to have_http_status(:success)
    end
  end
end
