require 'spec_helper'

describe 'layouts/posts.html.haml' do
  before(:each) do
    view.stub(:admin_signed_in?).and_return(true)
    assign(:years, [2013, 2012])
    render
  end

  it 'displays years' do
    rendered.should have_selector('a', content: '2013')
    rendered.should have_selector('a', content: '2012')
  end
end
