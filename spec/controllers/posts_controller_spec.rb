require 'spec_helper'

describe PostsController do

  describe "GET 'index'" do
    let!(:posts) do
      [Post.create!(
                    title: 'title1',
                    body: 'body1',
                    tags: 'tag1'
                    ),
       Post.create!(
                    title: 'title2',
                    body: 'body2',
                    tags: 'tag2'
                    )]
    end
    before(:each) { get 'index' }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns posts" do
      expect(assigns(:posts)).to eq posts
    end
  end

  describe "GET 'show'" do
    let!(:post) { Post.create!(
                              title: 'title one',
                              body: 'body',
                              tags: 'tag1'
                              ) }
    before(:each) { get 'show', id: post }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns post" do
      expect(assigns(:post)).to eq post
    end
  end

  describe "GET 'new'" do
    before(:each) { get 'new' }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns empty post" do
      expect(assigns(:post)).to be_new_record
    end
  end

  describe "POST 'create'" do
    let(:post_hash) do
      { title: 'hello',
        body: 'world',
        tags: 'foo,bar' }
    end
    
    context "when post is valid" do
      before(:each) do
        post 'create', post: post_hash
      end

      it "redirects to show" do
        expect(response).to redirect_to post_path(assigns(:post))
      end

      it "post is persisted" do
        expect(assigns(:post)).to be_persisted
      end
    end

    context "when post is not valid" do
      before(:each) do
        post_hash[:title] = ''
        post 'create', post: post_hash
      end

      it "not persisted" do
        expect(assigns(:post)).to_not be_persisted
      end
      
      it "adds error" do
        expect(assigns(:post).errors[:title].count).to eq 1
      end
    end
  end
end
