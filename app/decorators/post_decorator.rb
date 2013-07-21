class PostDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def body_as_html
    markdown.render(body).chomp.html_safe
  end

  def date
    created_at.strftime "%-m/%-d/%Y"
  end

private
  def markdown
    @@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end
end

# see https://gist.github.com/vlasar/5003493
class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value
end
