require 'spec_helper'

describe "posts/show.html.haml" do
  before(:each) do
    assign(:post, stub_model(Post, {
                               title: 'foo',
                               body: 'bar',
                               tags: ['baz']
                             }))
    render
  end

  it "displays post title" do
    expect(rendered).to contain 'foo'
  end

  it "displays post body" do
    expect(rendered).to contain 'bar'
  end

  it "displays post tags" do
    expect(rendered).to contain 'baz'
  end
end
