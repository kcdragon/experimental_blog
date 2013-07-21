require 'spec_helper'

describe PostDecorator do
  let(:post) do
    post = Post.create!(title: 'title',
                        body: "This is *bongos*, indeed.",
                        created_at: DateTime.new(2013, 7, 20)).decorate
  end

  describe "#body_as_html" do
    it "converts markdown to html" do
      expect(post.body_as_html).to eq "<p>This is <em>bongos</em>, indeed.</p>"
    end
  end

  describe "#date" do
    it "user-friendly format" do
      expect(post.date).to eq '7/20/2013'
    end
  end
end
