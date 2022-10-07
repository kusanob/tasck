class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task =Task.new(params[:id])
  end
  
  def create
    @task = Task.new(
      user_id: current_user.id,
      title: task_params[:title],
      detail: task_params[:detail]
      )
    if @task.save
      flash[:success] = "投稿しました！"
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
      flash[:success] = "更新しました！"
      redirect_to task_url
    else
    render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:success] = "削除しました！"
      redirect_to tasks_url
    else
      render :index
    end
  end
  
  private
    
    def task_params
      params.require(:task).permit(:title, :detail)
    end
  
end