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
    render
  end

  it "displays post titles" do
    expect(rendered).to contain 'title one'
    expect(rendered).to contain 'title two'
  end

  it 'displays links to tags' do
    expect(rendered).to have_selector 'a', content: 'foo'
    expect(rendered).to have_selector 'a', content: 'bar'
    expect(rendered).to have_selector 'a', content: 'baz'
  end
end
