require 'spec_helper'

describe Admin::PostsController do
  before(:each) do
    admin = Admin.create!(email: 'test@test.com',
                          password: '12345678',
                          password_confirmation: '12345678')
    sign_in admin
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
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

      it "redirects to all posts" do
        expect(response).to redirect_to admin_posts_path
      end

      it "post is persisted" do
        expect(assigns(:post)).to be_persisted
      end

      it "flashes notice" do
        expect(flash[:notice]).to_not be_empty
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

  describe "GET 'edit'" do
    let!(:post) { Post.create!(
                               title: 'title one',
                               body: 'body',
                               tags: 'tag1',
                               slug: 'title-one'
                               ) }
    before(:each) { get 'edit', id: 'title-one' }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns post" do
      expect(assigns(:post)).to eq post
    end
  end

  describe "PUT 'update'" do
    let(:post) do
      Post.create!({ title: 'hello',
                     body: 'world',
                     tags: 'foo,bar'
                   })
    end
    
    context "when post is valid" do
      before(:each) do
        put 'update', id: post.to_param, post: { title: 'hello 2', body: 'world 2', tags: 'foo,baz,bar' }
      end

      it "redirects to all posts" do
        expect(response).to redirect_to admin_posts_path
      end

      it "post is persisted" do
        expect(assigns(:post)).to be_valid
      end

      it "flashes notice" do
        expect(flash[:notice]).to_not be_empty
      end
    end

    context "when post is not valid" do
      before(:each) do
        put 'update', id: post.to_param, post: { title: '', body: 'world 2', tags: 'foo,baz,bar' }
      end

      it "not be valid" do
        expect(assigns(:post)).to_not be_valid
      end
      
      it "adds error" do
        expect(assigns(:post).errors[:title].count).to eq 1
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      post = Post.create!({ title: 'hello',
                            body: 'world',
                            tags: 'foo,bar'
                          })
      delete 'destroy', id: post.to_param
    end

    it "redirects to all posts" do
        expect(response).to redirect_to admin_posts_path
      end

    it "deletes post" do
      expect(Post.where(title: 'hello')).to_not be_exists
    end

    it "flashes notice" do
        expect(flash[:notice]).to_not be_empty
      end
  end
end
