class AdminController < ApplicationController
  def index
    @posts = PostDecorator.decorate_collection(Post.desc(:created_at).page(params[:page]).per(20))
  end
end
