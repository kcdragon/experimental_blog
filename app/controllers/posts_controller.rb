class PostsController < ApplicationController
  include Posts

  def index
    session[:year] = nil if params[:clear_year]

    if params[:clear_tags]
      session[:tags] = nil
    else
      @selected_tags = selected_tags
    end

    @posts = get_posts_for_year_and_tags

    set_available_facets

    @posts = decorate(@posts.desc(:created_at).page(params[:page]).per(5))
  end

  def show
    set_available_facets
    @post = Post.find_by(slug: params[:id]).decorate
  end
end
