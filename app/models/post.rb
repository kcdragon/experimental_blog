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
