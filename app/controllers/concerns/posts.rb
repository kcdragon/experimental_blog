module Posts

protected
  # REFACTOR post queries to Post model

  def get_posts_for_year_and_tags
    posts = get_posts_for_year
    posts = get_posts_for_tags posts
    posts
  end

  def get_posts_for_year
    if year
      posts = Post.all_in_year year, month
      session[:year] = year
    else
      posts = Post.all
    end
    posts
  end

  def get_posts_for_tags posts
    if selected_tags && selected_tags.count > 0
      session[:tags] = selected_tags
      return posts.tagged_with_all selected_tags
    end
    posts
  end

  def set_available_facets
    # REFACTOR move map reduce into Post model
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

    if selected_tags && selected_tags.count > 0
      @tags = Post.tagged_with_all(selected_tags).map_reduce(map, reduce).out(inline: true).map do |result|
        [result['_id'], result['value']['count']]
      end
    
      @tags = @tags.select do |result|
        !selected_tags.include?(result[0])
      end
    else
      @tags = Post.tags_with_weight
    end

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
    tags = session[:tags] || []
    tags = tags + params[:tags].split(',') if params[:tags]
    tags
  end
end
