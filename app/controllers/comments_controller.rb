class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    @comment.user_id = current_user.id
    @comment.body = params[:body]
    @comment.save!
    redirect_to post_path(@post)
  rescue StandardError => ex
    flash[:alert] = ex.message
    redirect_to(request.referrer)
  end
end
