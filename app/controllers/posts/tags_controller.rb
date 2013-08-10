class Posts::TagsController < ApplicationController
  include Posts

  layout 'posts'

  def destroy
    # TODO handle invalid tag and empty tags session
    session[:tags].delete(params.delete(:tag))

    if session[:tags].count > 0
      @selected_tags = selected_tags
    end

    @posts = get_posts_for_year_and_tags

    set_available_facets

    @posts = decorate(@posts.desc(:created_at).page(params[:page]).per(5))
    
    render 'posts/index'
  end
end
