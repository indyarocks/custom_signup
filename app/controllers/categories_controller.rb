class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    if params[:keyword]
      @categories = Category.user_categories_by_keyword(current_user, params[:keyword])
    else
      @categories = current_user.categories.all
    end

    respond_to do |format|
      format.html
      format.json {render json: @categories.to_json}
    end
  end

  def show
    @category = current_user.categories.where(id: params[:id])
    if @category.blank?
      flash[:danger] = 'Invalid category id.'
      redirect :back
    end
  end

  def create

  end

  def edit

  end

  def update

  end
end
