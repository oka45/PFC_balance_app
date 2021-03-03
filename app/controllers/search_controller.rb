class SearchController < ApplicationController


  def search
      food_name = params[:food_name] ||= '空欄'
      params = URI.encode_www_form_component(food_name)
      uri = URI.parse("https://apex.oracle.com/pls/apex/nutrition_management/search/food/#{params}")
      response = Net::HTTP.get_response(uri)
      result = JSON.parse(response.body)
      @food_information = result["items"]
  end

  

end
