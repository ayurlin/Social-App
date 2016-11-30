class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :requested_friendships
  include SessionsHelper
  include UsersHelper

  add_flash_types :success, :notice, :error

  def requested_friendships
    if current_user
      @user_friendships = current_user.user_friendships.all
      @count = @user_friendships.where(:state => 'requested').count
    end 
  end

end
