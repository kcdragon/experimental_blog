class PostsController < ApplicationController
  before_filter :set_available_facets

  def index
    if year
      posts = Post.all_in_year year, month

      session[:year] = year
    else
      posts = Post.all
    end

    @selected_tags = update_tags
    if @selected_tags
      session[:tags] = @selected_tags
      posts = posts.tagged_with_all @selected_tags
    end

    @posts = decorate(posts.desc(:created_at).page(params[:page]).per(5))
  end

  def show
    @post = Post.find_by(slug: params[:id]).decorate
  end

private
  def set_available_facets
    @tags = Post.tags_with_weight
    @years = Post.years.reverse
  end

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

  def update_tags
    return unless session[:tags] || params[:tags]
    tags = session[:tags] || []
    (tags << params[:tags].split(',')).flatten! if params[:tags]
    tags
  end
end
