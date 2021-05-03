require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'アカウントが有効である' do
    expect(user).to be_valid
  end
  it 'returns false for a user with nil digest' do
    expect(user.authenticated?('')).to be_falsy
  end
  describe "名前" do 
    context "有効" do 
        it "50文字までの場合" do 
            user.name = 'a' * 50
            expect(user).to be_valid
        end
    end
    context "無効" do 
        it '空欄の場合' do
            user.name = ' '
            expect(user).to be_invalid
        end
        it '51文字以上の場合' do
            user.name = 'a' * 51
            expect(user).to be_invalid
        end
    end
  end
  describe "メールアドレス" do
    context "有効" do
        it '255文字以下の場合' do
            user.email = 'a' * 242 + '@example.com'
            expect(user).to be_valid
        end
        it '正しいフォーマットの場合' do
            valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                                  first.last@foo.jp alice+bob@baz.cn)
            valid_addresses.each do |valid_address|
              user.email = valid_address
              expect(user).to be_valid 
            end
        end
    end
    context "無効" do
        it '空欄の場合' do
            user.email = ' '
            expect(user).to be_invalid
        end

        it '256文字以上の場合' do
            user.email = 'a' * 244 + '@example.com'
            expect(user).to be_invalid
        end
        it '間違ったフォーマットの場合' do
            invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                                foo@bar_baz.com foo@bar+baz.com)
            invalid_addresses.each do |invalid_address|
            user.email = invalid_address
            expect(user).to be_invalid
            end
        end
        it "重複の場合" do
            duplicate_user = user.dup
            user.save
            expect(duplicate_user).to be_invalid
        end
        it "重複は大文字小文字関係なく" do
            duplicate_user = user.dup
            duplicate_user.email = user.email.upcase
            user.save
            expect(duplicate_user).to be_invalid
        end
    end
  end
  describe "パスワード" do 
    context "有効" do 
        it  "6文字以上の場合" do
            user.password = user.password_confirmation = 'a' * 6
            expect(user).to be_valid
        end
    end
    context "無効" do
        it '空欄の場合' do
            user.password = user.password_confirmation = ' ' * 6
            expect(user).to be_invalid
        end
        
        it '5文字以下の場合' do
            user.password = user.password_confirmation = 'a' * 5
            expect(user).to be_invalid
        end
    end
  end

    
end