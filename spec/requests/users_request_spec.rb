require 'rails_helper'

RSpec.describe "users", type: :request do 
    let!(:user) { FactoryBot.create(:user) }
    let!(:other_user) { FactoryBot.create(:user) }
    let(:admin_user) { FactoryBot.create(:user, :admin_user) }
    describe "new" do
        context "ログインしている場合" do
            before do
                post login_path, params: { session: { email: user.email, password: user.password } }
            end
            it "新規登録画面が管理画面にリダイレクトされる" do
                get signup_path
                expect(response).to redirect_to "/foods" 
            end
        end
        context "ログインしてない場合" do
            it "新規登録画面が表示される" do
                get signup_path
                expect(response).to have_http_status "200"
                expect(response.body).to include "新規登録|PFCバランサー"
            end
        end
    end

    describe "index" do 
        context "ログインしている場合" do
            before do
                post login_path, params: { session: { email: user.email, password: user.password } }
            end
            it "管理画面は表示されずにリダイレクトされる(admin以外表示されない)" do
                get users_path
                expect(response).to redirect_to "/"       
            end
        end
        context "管理者は" do
            before do
                post login_path, params: { session: { email: admin_user.email, password: admin_user.password } }
            end
            it "管理画面を表示する" do
                get users_path
                expect(response).to have_http_status "200"
            end
        end
        context "ログインしてない場合" do
            it "一覧は表示されずリダイレクトされる" do
                get users_path
                expect(response).to redirect_to "/login"            
            end
        end
    end

    describe "show" do
        context "ログインしている場合" do
            before do
                post login_path, params: { session: { email: user.email, password: user.password } }
            end
            it "プロフィール画面が表示される" do 
                get edit_user_path(user)
                expect(response).to have_http_status "200"
            end
            it "自分以外のプロフィール画面は見れない" do 
                get edit_user_path(other_user)
                expect(response).to redirect_to "/"
            end
        end
        context "ログインしてない場合" do
            it "プロフィール画面は見れずリダイレクトされる" do 
                get edit_user_path(user)
                expect(response).to redirect_to "/login"
            end

        end

    end

    describe "edit" do
        context "ログインしている場合" do
            before do
                post login_path, params: { session: { email: user.email, password: user.password } }
            end
            it "編集画面が表示される" do 
                get user_path(user)
                expect(response).to have_http_status "200"
            end
            it "自分以外の編集画面は見れない" do 
                get user_path(other_user)
                expect(response).to redirect_to "/"
            end
        end
        context "ログインしてない場合" do
            it "編集画面は見れずリダイレクトされる" do 
                get user_path(user)
                expect(response).to redirect_to "/login"
            end

        end
    end

    describe "create" do 
            it "新規作成できる" do
                expect{
                    post users_path, params: { user:
                        FactoryBot.attributes_for(:user)
                    }
                }.to change(User, :count).by(1)
                expect(response).to redirect_to user_path(User.last)
                expect(is_logged_in?).to be_truthy
            end

    end 
    describe "update" do 
        context "ログインしている場合" do
            before do
                post login_path, params: { session: { email: user.email, password: user.password } }
            end
            it "自分情報は更新できる" do 
                patch user_path(user), params:{ user: {
                name: "岡　岡",
                email: user.email
                    }
                }
            expect(user.reload.name).to eq "岡　岡"
            end
            it "自分以外の更新はできない" do 
                patch user_path(other_user), params:{ user: {
                    name: user.name,
                    email: user.email
                   }
                }
                expect(response).to redirect_to "/"
            end

            it "管理者権限を一般ユーザーは付与できない" do 
                patch user_path(user), params:{ user: {
                    password: "password",
                    password_confirmation: "password",
                    admin: true
                   }
                }
                expect(user.reload.admin).to eq false
            end

        end
        context "ログインしていない場合" do 
            it "リダイレクトされる" do 
                patch user_path(other_user), params:{ user: {
                    name: user.name,
                    email: user.email
                   }
                }
                expect(response).to redirect_to "/login"
            end
        end
    end 
    describe "destroy" do 
        context "ログインしている場合" do
            before do
                post login_path, params: { session: { email: user.email, password: user.password } }
            end
            it "自分のアカウントは削除できる" do
                expect{
                    delete user_path(user), params: {
                        id: user.id
                    }
                }.to change(User, :count).by(-1)
            end 
            it "削除後top画面にリダイレクトされる" do 
                delete user_path(user), params: {
                        id: user.id
                    }
                expect(response).to redirect_to "/" 
            end
            it "他人は削除できない" do
                expect{
                    delete user_path(other_user), params: {
                        id: other_user.id
                    }
                }.to change(User, :count).by(0)
            end 
        end
        context "管理者は" do
            before do
                post login_path, params: { session: { email: admin_user.email, password: admin_user.password } }
            end
            it "削除できる" do
                expect{
                    delete user_path(user), params: {
                        id: user.id
                    }
                }.to change(User, :count).by(-1)
            end
            it "削除後管理画面にリダイレクトされる" do 
                delete user_path(user), params: {
                        id: user.id
                    }
                expect(response).to redirect_to users_url
            end
        end
        context "ログインしていない場合" do 
            it "削除はできない" do
                expect {
                    delete user_path(user), params:{
                        id: user.id
                    }
                }.to change(User, :count).by(0)
            end 
            it "削除しようとするとログイン画面にリダイレクトされる" do 
                delete user_path(user), params: {
                        id: user.id
                    }
            expect(response).to redirect_to "/login"          
            end
        end
    end 
      
    
  
end