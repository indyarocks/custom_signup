class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    if params[:keyword]
      @categories = Category.user_categories_by_keyword(current_user, params[:keyword])
    else
      @categories = current_user.categories.all
    end

    if request.xhr?
      html = render_to_string(:partial => 'categories/categories_listing', :layout => false, :locals => {categories: @categories})
      render json: {success: true, html: html} and return
    end
  end

  def autocompleter
    categories = Category.user_categories_by_keyword(current_user, params[:keyword]).collect{|cat| cat.name}
    render json: categories
  end

  def show
    @category = current_user.categories.where(id: params[:id])
    if @category.blank?
      flash[:danger] = 'Invalid category id.'
      redirect :back
    end
  end

  def create
    begin
      @category = current_user.categories.create!(name: params[:name])
    rescue ActiveRecord::RecordNotUnique => ex
      error = "Record Not Unique"
    rescue Exception => ex
      error = ex.message
    end
    if error.blank?
      render json: {success: true, message: 'Successfully created category'}
    else
      render json: {success: true, message: error}
    end
  end

  def edit

  end

  def update
    category = current_user.categories.find_by(id: params[:id])
    render json: {success: false, message: 'Invalid category'} and return if category.blank?

    category.name = params[:name]
    begin
      category.save!
    rescue ActiveRecord::RecordNotUnique => ex
      error = "Record Not Unique"
    rescue Exception => ex
      error = ex.message
    end
    if error.blank?
      render json: {success: true, message: 'Successfully updated category.'}
    else
      render json: {success: false, message: error}
    end
  end

  def destroy
    category = current_user.categories.find_by(id: params[:id])
    render json: {success: false, message: 'Invalid category'} and return if category.blank?

    if category.destroy
      render json: {success: true, message: 'Successfully deleted category.'}
    else
      render json: {success: false, message: category.errors.full_messages.join(',')}
    end
  end
end
