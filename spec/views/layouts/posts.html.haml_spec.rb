require 'spec_helper'

describe 'layouts/posts.html.haml' do
  let(:tags) { ['foo', 'bar', 'baz'] }
  let(:years) { ['2013', '2012'] }

  before(:each) do
    view.stub(:admin_signed_in?).and_return(true)
    assign(:years, years)
    assign(:tags, tags)
    render
  end

  it 'displays years' do
    years.each do |year|
      rendered.should have_selector('a', content: year)
    end
  end

  it 'displays tags' do
    tags.each do |tag|
      rendered.should have_selector('a', content: tag)
    end
  end
end
