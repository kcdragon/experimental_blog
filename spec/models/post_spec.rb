require 'spec_helper'

describe Post do

  it { respond_to :title }
  it { respond_to :body }
  it { respond_to :tags }
  it { respond_to :slug }
  
  let(:post) { Post.new(title: 'Hello World',
                        body: 'body') }
  subject { post }

  shared_examples 'cannot be nil or empty string' do
    it "cannot be nil" do
      subject.send(:"#{field}=", nil)
      expect(subject).to_not be_valid
    end

    it "cannot be empty string" do
      subject.send(:"#{field}=", '')
      expect(subject).to_not be_valid
    end
  end

  describe '#title' do
    it_behaves_like 'cannot be nil or empty string' do
      let(:field) { 'title' }
    end
  end

  describe '#body' do
    it_behaves_like 'cannot be nil or empty string' do
      let(:field) { 'body' }
    end
  end

  describe '#tags' do
    it 'defaults to empty string' do
      expect(subject.tags).to eq ''
    end
  end

  describe 'before create' do
    it 'generates slug' do
      expect { subject.save }.to change(post, :slug).from(nil).to('hello-world')
    end
  end
end
