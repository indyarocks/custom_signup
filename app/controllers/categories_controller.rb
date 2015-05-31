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
    @category = current_user.categories.create(name: params[:name])
    if @category.persisted?
      render json: {success: true, message: 'Successfully created category'}
    else
      render json: {success: true, message: @category.errors.full_messages.join(',')}
    end
  end

  def edit

  end

  def update
    category = current_user.categories.find_by(id: params[:id])
    render json: {success: false, message: 'Invalid category'} and return if category.blank?

    category.name = params[:name]
    if category.save
      render json: {success: true, message: 'Successfully updated category.'}
    else
      render json: {success: false, message: category.errors.full_messages.join(',')}
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
