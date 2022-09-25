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
    @task = Task.find(prams[:id])
  end
  
  def update
  end
  
end