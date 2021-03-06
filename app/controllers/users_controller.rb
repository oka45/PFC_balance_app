class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:index] 
  before_action :forbid_login_user, only: :new

  PER = 10

  def new
    @user = User.new
  end

  def index
    @users = User.page(params[:page]).per(PER)
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'PFCバランサーへようこそ！！'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      User.find(params[:id]).destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to users_url
    elsif @user.id == current_user.id
      User.find(params[:id]).destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to root_url
    else
      render 'show'
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                            :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
