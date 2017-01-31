class CommentsController < ApplicationController
  
  def create
    @task = Task.find(params[:task_id])
	  @comment = @task.comments.new(params[:comment].permit(:body))
	  @comment.user_id = current_user.id
	  @comment.save
      redirect_to task_path(@task)
  end
end
