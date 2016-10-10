class UserNotifier < ApplicationMailer
  default from: 'noreply@noreply.com'

  def friend_requested(user_friendship_id)
    user_friendship = UserFriendship.find(user_friendship_id)

    @user = user_friendship.user
    @friend = user_friendship.friend

    mail to: @friend.email,
         subject: '#{@user.name} wants to be Your friend'
  end

  def friend_request_accepted(user_friendship_id)
    user_friendship = UserFriendship.find(user_friendship_id)
    @user = user_friendship.user
    @friend = user_friendship.friend

    mail to: @user.email,
         subject: '#{@friend.name} has accepted your friend request.'
  end
    
end
