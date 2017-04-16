class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource only: :destroy

  def new
    build_comment
  end

  def create
    build_comment
    save_comment || render(:new)
  end

  def destroy
    trip = @comment.commentable.trip
    @comment.destroy
    redirect_to trip_path(trip)
  end

  private

  def build_comment
    @comment ||= comment_scope.build
    @comment.attributes = comment_params
    @comment.author = current_user
  end

  def save_comment
    redirect_to @commentable.trip if @comment.save
  end

  def commentable
    klass = params[:commentable_type].camelize.constantize
    @commentable ||= klass.find(params[:commentable_id])
  end

  def comment_scope
    commentable.comments
  end

  def comment_params
    comment_params = params[:comment]
    comment_params ? comment_params.permit(:text) : {}
  end
end
