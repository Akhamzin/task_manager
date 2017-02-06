class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.new(params[:comment].permit(:body))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to task_path(@task)
      flash[:notice] = t('comments.create.notice')
    else
      redirect_to task_path(@task)
      flash[:alert] = t('comments.create.alert')
    end
  end
end
