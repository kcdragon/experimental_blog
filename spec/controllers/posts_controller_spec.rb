require 'spec_helper'

describe PostsController do

  let!(:posts) do
    [Post.create!(
                  title: 'title1',
                  body: 'body1',
                  tags: 'one',
                  created_at: DateTime.new(2013, 7, 31)
                  ),
     Post.create!(
                  title: 'title2',
                  body: 'body2',
                  tags: 'one,two',
                  created_at: DateTime.new(2013, 7, 1)
                  ),
     Post.create!(
                  title: 'title3',
                  body: 'body3',
                  tags: 'one,three',
                  created_at: DateTime.new(2013, 6, 1)
                  ),
     Post.create!(
                  title: 'title4',
                  body: 'body4',
                  tags: 'two,three',
                  created_at: DateTime.new(2012, 7, 1))]
  end

  shared_examples_for 'filter' do
    it "assigns years" do
      expect(assigns(:years)).to match_array [2013, 2012]
    end

    it 'assigns tags' do
      expect(assigns(:tags)).to match_array [['one', 3], ['two', 2], ['three', 2]]
    end
  end
  
  describe "GET 'index'" do
    context 'all posts' do
      before(:each) { get 'index' }

      it "returns http success" do
        expect(response).to be_success
      end

      it "assigns posts" do
        expect(assigns(:posts).count).to eq posts.count
      end

      it_behaves_like 'filter'
    end

    context 'only posts in given year' do
      before(:each) { get 'index', year: '2013' }

      it "returns http success" do
        expect(response).to be_success
      end
      
      it "assigns posts" do
        expect(assigns(:posts).count).to eq 3
      end
    end

    context 'only posts in given year and month' do
      before(:each) { get 'index', year: '2013', month: '7' }

      it "returns http success" do
        expect(response).to be_success
      end
      
      it "assigns posts" do
        expect(assigns(:posts).count).to eq 2
      end
    end

    context 'only posts with the selected tag' do
      before(:each) { get 'index', tags: 'one' }

      it "returns http success" do
        expect(response).to be_success
      end
      
      it "assigns posts" do
        expect(assigns(:posts).count).to eq 3
      end
    end

    context 'only posts with the selected tags' do
      before(:each) { get 'index', tags: 'two,three' }

      it "returns http success" do
        expect(response).to be_success
      end
      
      it "assigns posts" do
        expect(assigns(:posts).count).to eq 1
      end
    end

    it "paginates posts"
    it "posts in descending order"
  end

  describe "GET 'show'" do
    before(:each) { get 'show', id: posts.first }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns post" do
      expect(assigns(:post)).to eq posts.first
    end

    it_behaves_like 'filter'
  end
end
