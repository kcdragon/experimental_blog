class Admin::PostsController < ApplicationController
  before_filter :authenticate_admin!

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
        format.html { redirect_to admin_posts_path, notice: "'#{@post.title}' has been published." }
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
        format.html { redirect_to admin_posts_path, notice: "'#{@post.title}' has been updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    post = Post.find_by(slug: params[:id])
    post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: "'#{post.title}' has been removed." }
    end
  end
end
