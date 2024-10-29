class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    comments = Comment.where(todo: params[:todo_id])
    render json: comments
  end

  def create
    comment = Comment.create comment_params
    comment.todo_id = params[:todo_id]
    if comment.save!
      render json:  comment.id, status: :created
    else
      render json: task.errors, status: :unprocessable_content
    end
  end

  def destroy
    comment = Comment. find_by(id: params[:id], todo_id: params[:todo_id])
    comment.destroy
    head :no_content
  end

  private
  def comment_params
    params.permit(:content)
  end
end
