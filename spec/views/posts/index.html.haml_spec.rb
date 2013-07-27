require 'spec_helper'

describe "posts/index.html.haml" do
  let(:post1) do
    stub_model(Post, {
                 title: 'title one',
                 body_as_html: 'body one',
                 tags: 'foo,bar',
                 slug: 'title-one',
                 date: DateTime.new(2013, 1, 1)
               })
  end

  let(:post2) do
    stub_model(Post, {
                 title: 'title two',
                 body_as_html: 'body two',
                 tags: 'bar,baz',
                 slug: 'title-two',
                 date: DateTime.new(2012, 1, 1)
               })
  end

  before(:each) do
    assign(:posts, Kaminari.paginate_array([
                                            post1,
                                            post2
                                           ]).page(1))
    assign(:years, [2013, 2012])
    render
  end

  it "displays post titles" do
    expect(rendered).to contain 'title one'
    expect(rendered).to contain 'title two'
  end

  it_should_behave_like 'page with filter'
end
