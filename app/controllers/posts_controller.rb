class PostsController < ApplicationController

  def index
    session[:year] = nil if params[:clear_year]

    if year
      posts = Post.all_in_year year, month
      session[:year] = year
    else
      posts = Post.all
    end

    if params[:clear_tags]
      session[:tags] = nil
    else
      @selected_tags = selected_tags
      if selected_tags
        session[:tags] = selected_tags
        posts = posts.tagged_with_all selected_tags
      end
    end

    set_available_facets

    @posts = decorate(posts.desc(:created_at).page(params[:page]).per(5))
  end

  def show
    set_available_facets
    @post = Post.find_by(slug: params[:id]).decorate
  end

private
  def set_available_facets
    #@tags = Post.tags_with_weight
    map = %Q{
      function() {
        this.tags_array.forEach(function(tag) {
          emit(tag, { 'count': 1 });
        });
      }
    }

    reduce = %Q{
      function(tag, values) {
        var result = { 'count': 0 };
        values.forEach(function(value) {
          result.count += value.count;
        });
        return result;
      }
    }

    # tags_with_weight only works with Post.all, not a sub-selection
    
    @tags = Post.tagged_with_all(selected_tags).map_reduce(map, reduce).out(inline: true).map do |result|
      [result['_id'], result['value']['count']]
    end
    
    @tags = @tags.select do |result|
      !selected_tags.include?(result[0])
    end if selected_tags

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

  def selected_tags
    return unless session[:tags] || params[:tags]
    @selected_tags ||= retrieve_tags
  end

  def retrieve_tags
    tags = session[:tags] || []
    (tags << params[:tags].split(',')).flatten! if params[:tags]
    tags
  end
end
