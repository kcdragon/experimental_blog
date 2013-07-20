class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(slug: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create params[:post]

    if @post.save
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
end
