class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end
end
