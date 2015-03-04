class PostsController < ApplicationController

  def create
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
  end

  def update
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
