class SessionsController < ApplicationController

  #http_basic_authenticate_with name: 'frodo', password: 'secret'

  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if(user && user.authenticate(params[:password]))
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Incorrect username or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  #def session_params
  #  params.require(:session).permit(:email, :password)
  #end

end
