shared_examples_for 'page with filter' do
  it 'displays years' do
    rendered.should have_selector('a', content: '2013')
    rendered.should have_selector('a', content: '2012')
  end
end

shared_examples_for 'http request' do
  it "returns http success" do
    expect(response).to be_success
  end
end
