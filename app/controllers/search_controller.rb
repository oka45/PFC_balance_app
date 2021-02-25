class SearchController < ApplicationController
require 'net/http'
  def search
    if params[:food_name]
      food_name = params[:food_name]
      params = URI.encode_www_form_component(food_name)
      uri = URI.parse("https://apex.oracle.com/pls/apex/nutrition_management/search/food/#{params}")
      response = Net::HTTP.get_response(uri)
      result = JSON.parse(response.body)
      if result["items"][0]
        @food_information = result["items"]
      end
    end
  end

end
