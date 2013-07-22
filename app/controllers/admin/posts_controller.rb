class Admin::PostsController < ApplicationController
  def index
    @posts = PostDecorator.decorate_collection(Post.desc(:created_at).page(params[:page]).per(20))
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create params[:post]

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_path }
      else
        format.html { render :edit }
      end
    end
  end

  def edit
    @post = Post.find_by(slug: params[:id])
  end

  def update
    @post = Post.find_by(slug: params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to admin_posts_path }
      else
        format.html { render :edit }
      end
    end
  end
end
