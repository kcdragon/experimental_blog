require 'spec_helper'

describe PostsController do

  describe "GET 'index'" do
    let!(:posts) do
      [Post.create!(
                    title: 'title1',
                    body: 'body1',
                    tags: ['tag1']
                    ),
       Post.create!(
                    title: 'title2',
                    body: 'body2',
                    tags: ['tag2']
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
                              tags: ['tag1']
                              ) }
    before(:each) { get 'show', slug: post }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns post" do
      expect(assigns(:post)).to eq post
    end
  end
end
