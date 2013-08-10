require 'spec_helper'

describe Posts::TagsController do
  let!(:posts) do
    [
     FactoryGirl.create(:post_one),
     FactoryGirl.create(:post_two),
     FactoryGirl.create(:post_three),
     FactoryGirl.create(:post_four)
    ]
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      session[:tags] = ['one', 'two']
      delete 'destroy', tag: 'two'
    end

    it_behaves_like 'http request'

    it 'removes tag from session' do
      expect(session[:tags]).to match_array ['one']
    end

    it 'selected tags does not include tag' do
      expect(assigns(:selected_tags)).to match_array ['one']
    end

    it 'tag is available to select' do
      expect(assigns(:tags)).to match_array [['two', 1], ['three', 1]]
    end

    it 'posts with tagged with selected tags' do
      expect(assigns(:posts).count).to eq 3
    end

    context 'when the last selected tag is removed' do
      before(:each) do
        session[:tags] = ['one']
        delete 'destroy', tag: 'one'
      end

      it 'all posts are displayed' do
        expect(assigns(:posts).count).to eq posts.count
      end
    end
  end
end
