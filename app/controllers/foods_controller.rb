class FoodsController < ApplicationController
  before_action :logged_in_user, only:[:edit, :create, :destroy, :management ]

  def management
    @food = current_user.foods.build
    food_name = params[:name] ||= '空欄'
    encode = URI.encode_www_form_component(food_name)
    uri = URI.parse("https://apex.oracle.com/pls/apex/nutrition_management/search/food/#{encode}")
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body, symbolize_names: true)
    @food_information = result[:items]
    @foods = current_user.foods

  end

  def create #reateページに食品情報も見せる
    @food = current_user.foods.build(food_params)
    if @food.save
      flash[:success] = "保存しました"
      redirect_to management_url
    else
      render 'foods/management'
    end
  end

  def destroy
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :protein, :carbohydrate, :fat,
               :salt_equivalents, :calorie ,:quantity, :time_zone)
  end
end
