class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post ||= Post.find(params[:id])
  end

  def new
    @post = Post.new
    render :new
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post ||= Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :sub_id, :title, :url)
    end

    def require_author
      @post = Post.find(params[:id])
      unless current_user.id == @post.author_id
        flash[:error] = "You are not the author"
        redirect_to post_url(@post)
      end
    end

end
