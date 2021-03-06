class Post
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  before_create :generate_slug

  field :title, type: String
  field :body, type: String
  field :slug, type: String # TODO add date to slug

  validates_presence_of :title
  validates_presence_of :body

  def self.all_in_year year, month = nil
    start_month = month || '1'
    end_month = month || '12'
    start = DateTime.parse "#{year}-#{start_month}-1}"
    end_ = DateTime.parse "#{year}-#{end_month}-31}"
    Post.between created_at: start..end_
  end

  def self.years
    posts = Post.all
    posts.map { |p| p.created_at.year }.uniq
  end

  def to_param
    self.slug
  end

private
  def generate_slug
    self.slug = slugify(self.title)
  end

  def slugify str
    str.downcase.strip.gsub(/[\W\s]/, '-').squeeze('-').chomp('-')
  end
end
