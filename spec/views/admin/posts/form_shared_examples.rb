require 'spec_helper'

shared_examples 'post form' do
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
