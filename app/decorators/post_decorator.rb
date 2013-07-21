class PostDecorator < Draper::Decorator
  delegate_all

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
