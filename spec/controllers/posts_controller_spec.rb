require 'spec_helper'

describe PostsController do

  let!(:posts) do
    [
     FactoryGirl.create(:post_one),
     FactoryGirl.create(:post_two),
     FactoryGirl.create(:post_three),
     FactoryGirl.create(:post_four)
    ]
  end

  shared_examples_for 'filter' do
    it "assigns years" do
      expect(assigns(:years)).to match_array [2013, 2012]
    end

    it 'assigns tags' do
      expect(assigns(:tags)).to match_array [['one', 3], ['two', 2], ['three', 2]]
    end
  end

  shared_examples_for 'result of 1 post' do
    it_behaves_like 'http request'

    it "assigns posts" do
      expect(assigns(:posts).count).to eq 1
    end
  end

  shared_examples_for 'all posts displayed' do
    it "assigns posts" do
      expect(assigns(:posts).count).to eq posts.count
    end
  end
  
  describe "GET 'index'" do
    context 'all posts' do
      before(:each) { get 'index' }
      it_behaves_like 'http request'
      it_behaves_like 'all posts displayed'
      it_behaves_like 'filter'
    end

    context 'only posts in given year' do
      before(:each) { get 'index', year: '2013' }

      it_behaves_like 'http request'

      it "assigns posts" do
        expect(assigns(:posts).count).to eq 3
      end
    end

    context 'only posts in given year and month' do
      before(:each) { get 'index', year: '2013', month: '7' }

      it_behaves_like 'http request'
      
      it "assigns posts" do
        expect(assigns(:posts).count).to eq 2
      end
    end

    context 'only posts with the selected tag' do
      before(:each) { get 'index', tags: 'one' }

      it_behaves_like 'http request'
      
      it "assigns posts" do
        expect(assigns(:posts).count).to eq 3
      end
    end

    context 'only posts with the selected tags' do
      before(:each) { get 'index', tags: 'two,three' }

      it_behaves_like 'result of 1 post'
    end

    context 'posts with tag in param and tag in session' do
      before(:each) do
        session[:tags] = ['two']
        get 'index', tags: 'three'
      end

      it_behaves_like 'result of 1 post'
    end

    context 'year selected followed by tag' do
      before(:each) do
        get 'index', year: '2013'
        get 'index', tags: 'two'
      end

      it_behaves_like 'result of 1 post'
    end

    context 'tag selected followed by year' do
      before(:each) do
        get 'index', tags: 'two'
        get 'index', year: '2013'
      end

      it_behaves_like 'result of 1 post'
    end

    context 'clear selected tags' do
      before(:each) do
        session[:tags] = ['two', 'three']
        get 'index', clear_tags: true
      end
      it_behaves_like 'http request'
      it_behaves_like 'all posts displayed'
      it_behaves_like 'filter'
    end

    context 'clear year selection' do
      before(:each) do
        session[:year] = '2013'
        get 'index', clear_year: true
      end
      it_behaves_like 'http request'
      it_behaves_like 'all posts displayed'
      it_behaves_like 'filter'
    end

    context 'when year is cleared, selected tags remain' do
      before(:each) do
        session[:tags] = ['two']
        session[:year] = '2013'
        get 'index', clear_year: true
      end

      it_behaves_like 'http request'

      it 'displays two posts' do
        expect(assigns(:posts).count).to eq 2
      end

      it 'year is empty' do
        expect(assigns(:year)).to be_nil
      end

      it 'tags is "one" and "three"' do
        expect(assigns(:tags)).to match_array [['one', 1], ['three', 1]]
      end

      it 'selected tags is "two"' do
        expect(assigns(:selected_tags)).to match_array ['two']
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
