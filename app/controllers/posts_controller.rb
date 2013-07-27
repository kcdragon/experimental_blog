class PostsController < ApplicationController
  def index
    if params[:year]
      posts = Post.all_in_year params[:year], params[:month]
    else
      posts = Post.all
    end

    @years = Post.years.reverse
    @posts = decorate(posts.desc(:created_at).page(params[:page]).per(5))
  end

  def show
    @years = Post.years.reverse
    @post = Post.find_by(slug: params[:id]).decorate
  end

private
  def decorate posts
    PostDecorator.decorate_collection posts
  end

  def paginate posts
  end
end
