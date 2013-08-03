require 'spec_helper'

describe 'layouts/posts.html.haml' do
  let(:tags) { [['foo', 3], ['bar',2], ['baz',2]] }
  let(:selected_tags) { ['car', 'cdr'] }
  let(:years) { ['2013', '2012'] }

  before(:each) do
    view.stub(:admin_signed_in?).and_return(false)
    assign(:years, years)
    assign(:tags, tags)
  end

  context 'when tags are selected' do
    before(:each) do
      assign(:selected_tags, selected_tags)
      render
    end

    it 'displays years' do
      years.each do |year|
        rendered.should have_selector('a', content: year)
      end
    end

    it 'displays tags' do
      tags.each do |tag|
        rendered.should have_selector('a') do |link|
          link.should contain(/#{tag}.*\d+.*/)
        end
      end
    end

    it 'displays selected tags' do
      selected_tags.each do |tag|
        rendered.should contain(tag)
      end
    end
  end

  context 'when no tags are selected' do
    before(:each) { render }

    it 'does not display selected tags' do
      selected_tags.each do |tag|
        rendered.should_not contain(tag)
      end
    end
  end
end
