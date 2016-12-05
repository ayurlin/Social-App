class PagesController < ApplicationController

  def index
    @users = User.includes(posts: [comments: :user])
    @posts = Post.order(:updated_at).page params[:page]
    if params[:search]
      if logged_in?
        @users = User.where.not(id: current_user.id).search(params[:search]).order("created_at DESC")
      else
        @users = User.search(params[:search]).order("created_at DESC")
      end
    end
  end

  def suggest
    @search = User.all
    render json: @search.where('name like ?', "%#{params[:query]}%").or(@search.where('last_name like ?', "%#{params[:query]}%"))
  end

end
