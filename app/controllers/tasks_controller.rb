class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
  end
  
  def create
    @task = Task.new(
      title: params[:title], 
      detail: params[:detail],
      user_id: current_user.id,
    )
    if @task.save
      flash[:notice] = "投稿しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "更新しました。"
      redirect_to @task
    else
      edit
    end
  end
  
end