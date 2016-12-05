class PagesController < ApplicationController

  def index
    @users = User.includes(posts: [comments: :user])
    @posts = Post.order(:updated_at).page params[:page]
  end

  def suggest
    if logged_in?
      @search = User.where.not(id: current_user.id)
    else
      @search = User.all
    end
    render json: @search.where('name like ?', "%#{params[:query]}%").or(@search.where('last_name like ?', "%#{params[:query]}%"))
  end

end
