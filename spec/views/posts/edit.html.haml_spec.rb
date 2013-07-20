require 'spec_helper'

require_relative 'form_shared_examples'

describe "posts/edit.html.haml" do
  before(:each) do
    assign(:post, Post.create!({
                               title: 'title',
                               body: 'body',
                               tags: 'foo,bar'}))
    render
  end

  it_behaves_like 'post form'
end

