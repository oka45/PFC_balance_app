class SessionsController < ApplicationController
  before_action :forbid_login_user, only: :new

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = 'ログインしました'
      redirect_back_or(@user)
    else
      flash.now[:danger] = "メールアドレス又は、パスワードが有効でないため、ログイン失敗"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
