require 'rails_helper'

RSpec.describe "static_pages", type: :request do

  describe "GET /" do
    it "ホーム画面が表示されているか" do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include "TOP|PFCバランサー"
    end
  end
  describe "GET /about" do
    it "用途画面が表示されているか" do
      get about_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include "用途|PFCバランサー"
    end
  end
end
