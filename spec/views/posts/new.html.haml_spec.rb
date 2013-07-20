require 'spec_helper'

require_relative 'form_shared_examples'

describe "posts/new.html.haml" do
  before(:each) do
    assign(:post, Post.new)
    render
  end

  it_behaves_like 'post form'
end
