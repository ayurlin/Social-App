class UserFriendshipsController < ApplicationController

  def index
    @user_friendships = current_user.user_friendships.all
    if @user_friendships.count > 0 
      @user_friendships
    else
      flash[:notice] = 'Youd dont have friends yet'
    end
  end

  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.accept!
      flash[:notice] = "You are now friend with #{@user_friendship.friend.name}"
    else
      flash[:notice] = 'This friendship could not be accepted'
    end
    redirect_to friends_path
  end
  
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
      @user_friendship = UserFriendship.request(current_user, @friend)
      if @user_friendship.new_record?
        flash[:error] = 'There was a problem creating this friend request'
      else
        redirect_to user_path(@friend)
        flash[:notice] = 'Friend request has been sent'
      end
    else
      flash[:error] = 'Friend required'
    end
  end

  def edit
    @user_friendship = current_user.user_friendships.find(params[:id])
    @friend = @user_friendship.friend
  end

  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.destroy
      redirect_to friends_path
      flash[:success] = 'destroyed'
    else
      flash[:error] = 'friendship could not be destroyed'
     end 
  end

  private

  def user_friendship_params
    params.require(:user_friendship).permit(:user, :friend, :user_id, :friend_id, :state)
  end

end
