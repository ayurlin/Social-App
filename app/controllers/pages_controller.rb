class PagesController < ApplicationController
  def index
    @users = User.includes(posts: [comments: :user])
  end
end
