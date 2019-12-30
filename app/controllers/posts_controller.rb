class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new
    post.update_attributes!(post_params)
    redirect_to('/')
  rescue StandardError => ex
    flash[:alert] = ex.message
    redirect_to(request.referrer)
  end

  def edit
    @post = Post.find(params[:id])
    if current_user.blank? || @post.user_id != current_user.id
      flash[:alert] = I18n.t('unauthorized.default')
      redirect_to('/')
    end
  end

  def update
    post = Post.find(params[:id])
    if current_user.present? && post.user_id.eql?(current_user.id)
      post.update_attributes!(post_params)
    else
      flash[:alert] = I18n.t('unauthorized.default')
    end
    redirect_to('/')
  rescue StandardError => ex
    flash[:alert] = ex.message
    redirect_to(request.referrer)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :image)
  end
end
