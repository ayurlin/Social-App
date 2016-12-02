class PagesController < ApplicationController

  def index
    @users = User.includes(posts: [comments: :user])
    @posts = Post.all
    if params[:search]
      if logged_in?
        @users = User.where.not(id: current_user.id).search(params[:search]).order("created_at DESC")
      else
        @users = User.search(params[:search]).order("created_at DESC")
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def suggest
    @example = User.all
    @search = @example.collect { |user| user.name }
    render json: @search
  end

end
