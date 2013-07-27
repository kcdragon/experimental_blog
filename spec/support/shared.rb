shared_examples_for 'page with filter' do
  it 'displays years' do
    rendered.should have_selector('a', content: '2013')
    rendered.should have_selector('a', content: '2012')
  end
end
