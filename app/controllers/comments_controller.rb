class CommentsController < ApplicationController
  before_action :set_lecture, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.name_student = current_user.first_name
    @comment.lecture = @lecture
    if @comment.save
      redirect_to lecture_path(@lecture)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end

  def comment_params
    params.require(:comment).permit(:name_student, :content)
  end
end
