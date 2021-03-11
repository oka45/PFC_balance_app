class FoodsController < ApplicationController
  before_action :logged_in_user, only:[:edit, :create, :destroy, :management ]

  def index
    food_name = params[:name] ||= '空欄'
    encode = URI.encode_www_form_component(food_name)
    uri = URI.parse("https://apex.oracle.com/pls/apex/nutrition_management/search/food/#{encode}")
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body, symbolize_names: true)
    @food_information = result[:items]
    @food = current_user.foods.build
    @foods = current_user.foods.all
    if params[:bottun].to_i == 1
      @edit_food = 1 #編集前画面
    else
      @edit_food = 2 #編集中画面
    end
    @update_food = current_user.foods.find_by(params[:id])

  end

  def create #reateページに食品情報も見せる
    @food = current_user.foods.build(food_params)
    if @food.save
      flash[:success] = "保存しました"
      redirect_to foods_url
    else
      render 'foods'
    end
  end

  def update
    if @food  = current_user.foods.update(food_params)
      flash[:success] = "食事情報を変更しました"
      redirect_to foods_url
    else
      render  'foods/index'
    end
  end

  def destroy
    food = Food.find(params[:id])
    if food.user_id == current_user.id
      food.destroy
      flash[:success] = "削除しました"
      redirect_to foods_url
    end
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :protein, :carbohydrate, :fat,
               :salt_equivalents, :calorie ,:quantity, :time_zone)
  end
end
