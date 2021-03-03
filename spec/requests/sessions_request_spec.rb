require 'rails_helper'

RSpec.describe SessionsController do

  describe "GET /"
   it "ログイン画面が表示されているか(render new)" do
     get '/login'
     expect(response).to have_http_status(200)
   end
end
