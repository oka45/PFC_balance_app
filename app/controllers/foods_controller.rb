class FoodsController < ApplicationController
  before_action :logged_in_user
  before_action :food_list

  def index
    #検索用
    @food_name = params[:name] ||= '空欄'
    encode = URI.encode_www_form_component(@food_name)
    uri = URI.parse("https://apex.oracle.com/pls/apex/nutrition_management/search/food/#{encode}")
    @response = Net::HTTP.get_response(uri)
    if @response.code == "400"
      flash[:warning] = "空白が含まれる為、検索できません"
      flash.discard(:warning)
      render 'index'
    else
      result = JSON.parse(@response.body, symbolize_names: true)
      @food_information = result[:items]
      if @food_information.blank? && @food_name != "空欄"
        flash[:warning] = "該当する食品がありませんでした"
        flash.discard(:warning)
      elsif @food_information.present?
        flash[:success] = "#{@food_information.count}件の食品が該当しました"
        flash.discard(:success)
      end
    end
    #保存するためのインスタンス
    @food = current_user.foods.build
    #編集画面の切替
    params[:bottun].to_i == 2 ? @edit_food = 2 : @edit_food = 1
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
      redirect_to "/foods.#{@path}"
    end
  end

  private

  def food_list
    #選択した日付の食品　閲覧、削除、編集
    @path = Date.parse(params[:format] ||= Date.current.strftime('%Y/%m/%d'))
    @foods = current_user.foods.where(date: params[:format] ||= Date.current.strftime('%Y/%m/%d'))
    @food_morning = @foods.where(time_zone: "朝")
    @food_lunch = @foods.where(time_zone: "昼")
    @food_night = @foods.where(time_zone: "夜")
    @food_snack = @foods.where(time_zone: "間食")
    @food_get_up = @foods.where(time_zone: "起床")
    @food_going_to_bed = @foods.where(time_zone: "就寝")
    #カレンダーに表示する用
    @all_foods = current_user.foods.all
  end

  def food_params
    params.require(:food).permit(:food_name, :protein, :carbohydrate, :fat,
               :salt_equivalents, :calorie ,:quantity, :time_zone, :date)
  end

  def update_food_params
    params.permit(:food_name, :protein, :carbohydrate, :fat,
               :salt_equivalents, :calorie ,:quantity, :time_zone, :date)
  end
end
