class PagesController < ApplicationController
  def index
    @users = User.includes(posts: [comments: :user])
    @posts = Post.all
  end
end
