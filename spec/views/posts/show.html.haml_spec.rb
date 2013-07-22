require 'spec_helper'

describe "posts/show.html.haml" do
  before(:each) do
    assign(:post, stub_model(Post, {
                               title: 'foo',
                               body_as_html: 'bar',
                               tags: 'baz',
                               slug: 'foo',
                               date: DateTime.now
                             }))
    render
  end

  it "displays post title" do
    expect(rendered).to contain 'foo'
  end

  it "displays post body" do
    expect(rendered).to contain 'bar'
  end

  it "displays post date" do
    expect(rendered).to contain DateTime.now.year.to_s
    expect(rendered).to contain DateTime.now.month.to_s
    expect(rendered).to contain DateTime.now.day.to_s
  end

  it "displays post created at" do
    expect(rendered).to contain 'baz'
  end
end
