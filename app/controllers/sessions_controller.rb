class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to @user, :success => 'You are now logged in'
    else
      flash.now[:error] = 'Wrong email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, :success => 'You are now logged out'
  end
end
