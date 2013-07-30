class PostsController < ApplicationController
  def index
    if year
      posts = Post.all_in_year year, month
    else
      posts = Post.all
    end

    if tags
      posts = posts.tagged_with_all tags
    end

    @tags = Post.tags_with_weight
    @years = Post.years.reverse
    @posts = decorate(posts.desc(:created_at).page(params[:page]).per(5))
  end

  def show
    @tags = Post.tags_with_weight
    @years = Post.years.reverse
    @post = Post.find_by(slug: params[:id]).decorate
  end

private
  def decorate posts
    PostDecorator.decorate_collection posts
  end

  def paginate posts
  end

  def year
    params[:year] || session[:year] || nil
  end

  def month
    params[:month] || session[:month] || nil
  end

  def tags
    return unless params[:tags] || session[:tags]
    tags = params[:tags].split(',') rescue []
    tags | (session[:tags] || [])
  end
end
