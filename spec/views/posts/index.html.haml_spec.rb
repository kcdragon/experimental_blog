require 'spec_helper'

describe "posts/index.html.haml" do
  before(:each) do
    assign(:posts, [
                    stub_model(Post, {
                                 title: 'title one',
                                 body: 'body one',
                                 tags: 'foo,bar',
                                 slug: 'title-one'
                               }),
                    stub_model(Post, {
                                 title: 'title two',
                                 body: 'body two',
                                 tags: 'bar,baz',
                                 slug: 'title-two'
                               })
                    ])
    render
  end

  it "displays post titles" do
    expect(rendered).to contain 'title one'
    expect(rendered).to contain 'title two'
  end
end
