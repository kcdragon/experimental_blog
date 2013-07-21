require 'spec_helper'

describe "posts/index.html.haml" do
  before(:each) do
    assign(:posts, [
                    stub_model(Post, {
                                 title: 'title one',
                                 body_as_html: 'body one',
                                 tags: 'foo,bar',
                                 slug: 'title-one',
                                 date: DateTime.now
                               }),
                    stub_model(Post, {
                                 title: 'title two',
                                 body_as_html: 'body two',
                                 tags: 'bar,baz',
                                 slug: 'title-two',
                                 date: DateTime.now
                               })
                    ])
    render
  end

  it "displays post titles" do
    expect(rendered).to contain 'title one'
    expect(rendered).to contain 'title two'
  end
end
