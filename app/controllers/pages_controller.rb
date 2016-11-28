class PagesController < ApplicationController
  def index
    @users = User.includes(posts: [comments: :user])
    @posts = Post.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
