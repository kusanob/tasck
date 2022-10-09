class TasksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_user, only: :destroy
  
  def index
    @tasks = Task.where(user_id:current_user.id)
  end
  
  def show
    @task = Task.find(params[:id])
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
      params.require(:task).permit(:title, :detail).merge(user_id: current_user.id)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end