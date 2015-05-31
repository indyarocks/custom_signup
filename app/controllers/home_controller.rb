class HomeController < ApplicationController
  def index
    if current_user
      redirect_to categories_path and return
    end
  end
end