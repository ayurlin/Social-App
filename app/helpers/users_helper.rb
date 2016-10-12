module UsersHelper

  def is_friend
    current_user.friends.ids.include? @user.id
  end

  def same_user
    if logged_in?
      current_user.id == @user.id
    end
  end

end
