class StaticPagesController < ApplicationController
  before_action :forbid_login_user, only: :home
  def home
  end

  def about
  end

end
