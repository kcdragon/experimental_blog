class PostsController < ApplicationController
  def index
    @posts = PostDecorator.decorate_collection(Post.desc(:created_at).page(params[:page]).per(5))
  end

  def show
    @post = Post.find_by(slug: params[:id]).decorate
  end
end
