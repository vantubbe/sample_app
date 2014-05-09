class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit,:update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if(@user.update_attributes(user_params))
      #handle update
      flash[:success] = "Your profile has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App #{@user.name}"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
