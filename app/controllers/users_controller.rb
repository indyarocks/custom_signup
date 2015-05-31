class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      flash[:success] = 'Signed up successfully.'
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to '/', alert: 'User does not exist.' if @user.blank?
  end

  def edit

  end

  def update

  end

  private
    def create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end