class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :show]
  before_action :correct_user, only: [:edit, :update, :show]

  def index
    @users = User.all.includes(:categories)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Signed up successfully.'
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.blank?
      flash[:danger] ='User does not exist.'
      redirect_to '/'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user.blank?
      flash[:danger] ='User does not exist.'
      redirect_to '/'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    # Confirms the correct user.
    def correct_user
      @user = User.find_by(id: params[:id])
      unless current_user?(@user)
        flash[:danger] = "You do not have priviledge to take this action."
        redirect_to(root_url)
      end
    end
end