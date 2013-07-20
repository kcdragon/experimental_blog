require 'spec_helper'

describe "posts/new.html.haml" do
  before(:each) do
    assign(:post, Post.new)
    render
  end

  it "displays post title" do
    expect(rendered).to have_selector 'input', type: 'text', name: 'post[title]'
  end

  it "displays post body" do
    expect(rendered).to have_selector 'textarea', name: 'post[body]'
  end

  it "displays post tags" do
    expect(rendered).to have_selector 'input', type: 'text', name: 'post[tags]'
  end
end
