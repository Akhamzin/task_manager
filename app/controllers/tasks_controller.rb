class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.client_id = current_user.id
    @task.status = "новая"
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(params[:task].permit(:admin_id, :name, :description, :status))
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = t('tasks.destroy.notice')
    redirect_to root_path
  end

  private
    def task_params
      params.require(:task).permit(:admin_id, :client_id, :name, :description)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end
