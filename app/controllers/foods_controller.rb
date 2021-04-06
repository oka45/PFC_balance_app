class FoodsController < ApplicationController
  before_action :logged_in_user
  def index
    #検索用
    food_name = params[:name] ||= '空欄'
    encode = URI.encode_www_form_component(food_name)
    uri = URI.parse("https://apex.oracle.com/pls/apex/nutrition_management/search/food/#{encode}")
    @response = Net::HTTP.get_response(uri)
    if @response.code == "400"
      @all_foods = current_user.foods.all
      @path = Date.parse(params[:format] ||= Date.current.strftime('%Y/%m/%d'))
      render 'index'
    else
      result = JSON.parse(@response.body, symbolize_names: true)
      @food_information = result[:items]
      unless @food_information.empty?
        flash[:success] = "#{@food_information.count}件の食品が該当しました"
        flash.discard(:success)
      end
    end

    #保存するためのインスタンス
    @food = current_user.foods.build
    #選択した日付の食品　閲覧、削除、編集
    @foods = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'))
    @food_morning = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'), time_zone: "朝")
    @food_lunch = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'), time_zone: "昼")
    @food_night = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'), time_zone: "夜")
    @food_snack = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'), time_zone: "間食")
    @food_get_up = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'), time_zone: "起床")
    @food_going_to_bed = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'), time_zone: "就寝")
    if params[:bottun].to_i == 2
      @edit_food = 2 #編集中画面
    else
      @edit_food = 1 #編集前後画面
    end
    #カレンダーに表示する用
    @all_foods = current_user.foods
    @path = Date.parse(params[:format] ||= Date.current.strftime('%Y/%m/%d'))
  end

  def create #createページに食品情報も見せる
    @food = current_user.foods.build(food_params)

    if @food.save
      flash[:success] = "保存しました"
      redirect_to "/foods.#{Date.parse(params[:food][:date] ||= Date.current.strftime('%Y/%m/%d'))}"
    else
      render 'index'
    end
  end

  def update
    @update_food = current_user.foods.find(params[:id])
    if @update_food.update(update_food_params)
      flash[:success] = "食事情報を変更しました"
      redirect_to "/foods.#{@update_food.date.to_s}"
    else
      render  'foods/index'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.user_id == current_user.id
      @food.destroy
      flash[:success] = "削除しました"
      redirect_to "/foods.#{Date.parse( params[:format] ||= Date.current.strftime('%Y/%m/%d'))}"
    end
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :protein, :carbohydrate, :fat,
               :salt_equivalents, :calorie ,:quantity, :time_zone, :date)
  end

  def update_food_params
    params.permit(:food_name, :protein, :carbohydrate, :fat,
               :salt_equivalents, :calorie ,:quantity, :time_zone, :date)
  end
end
