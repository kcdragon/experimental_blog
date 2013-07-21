class PostsController < ApplicationController
  def index
    @posts = PostDecorator.decorate_collection(Post.desc(:created_at))
  end

  def show
    @post = Post.find_by(slug: params[:id]).decorate
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

  def edit
    @post = Post.find_by(slug: params[:id])
  end

  def update
    @post = Post.find_by(slug: params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post }
      else
      end
    end
  end
end
