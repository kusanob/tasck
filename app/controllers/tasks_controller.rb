class TasksController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_task, only: [:edit, :update, :show]
  before_action :admin_user, only: :destroy
  
  def index
    @tasks = Task.where(user_id: current_user.id).order(created_at: :desc)
  end
  
  def new
    @task = Task.new(params[:id])
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "投稿しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end
  
  def show
    @task = Task.find(params[:id])
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
    @task.destroy
    flash[:success] = "#{@task.title}削除しました！"
    redirect_to tasks_url
  end
  
  private
    
    def task_params
      params.require(:task).permit(:title, :detail).merge(user_id: current_user.id)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def correct_task
      unless current_user
        redirect_to tasks_url
      end
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end  
