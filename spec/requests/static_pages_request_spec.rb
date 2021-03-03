require 'rails_helper'

RSpec.describe StaticPagesController do

  describe "GET /"
    it "ホーム画面が表示されているか(render home)" do
      get '/'
      expect(response).to have_http_status(200)
    end

    describe "GET /about"
      it "用途画面が表示されているか(render about)" do
        get '/about'
        expect(response).to have_http_status(200)
      end
  end
