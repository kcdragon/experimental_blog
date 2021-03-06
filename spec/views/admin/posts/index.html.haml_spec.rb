require 'spec_helper'

describe "admin/posts/index.html.haml" do
  before(:each) do
    post1 = stub_model(Post, {
                         title: 'title one',
                         body_as_html: 'body one',
                         tags: 'foo,bar',
                         slug: 'title-one',
                         date: DateTime.now
                       })
    post2 = stub_model(Post, {
                         title: 'title two',
                         body_as_html: 'body two',
                         tags: 'bar,baz',
                         slug: 'title-two',
                         date: DateTime.now
                       })
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

  it "displays post date" do
    expect(rendered).to contain DateTime.now.year.to_s
    expect(rendered).to contain DateTime.now.month.to_s
    expect(rendered).to contain DateTime.now.day.to_s
  end

  it "displays edit links" do
    expect(rendered).to have_selector :a, content: 'Edit'
  end

  it "displays delete links" do
    expect(rendered).to have_selector :a, content: 'Delete'
  end

  it "displays new post link" do
    expect(rendered).to have_selector :a, content: 'New Post'
  end
end
