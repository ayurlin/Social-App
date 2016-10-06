class UserFriendshipsController < ApplicationController

  def new
    if logged_in?
      if params[:friend_id]
        @friend = User.find(params[:friend_id])
        @user_friendship = current_user.user_friendships.new(friend: @friend)
      else
        flash[:error] = 'Friend required'
      end
    else
      redirect_to login_path, notice: 'You must log in'
    end

  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.find(params[:user_friendship][:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship.save
      redirect_to user_path(@friend)
      flash[:notice] = 'You are firends now'
    else
      flash[:error] = 'Friend required'
    end
  end

  # def destroy
  #   @user_friendship = current_user.user_friendships.find(friend: @friend)
  #   @user_friendship.destroy
  #   flash[:error] = 'destroyed'
  # end

end
