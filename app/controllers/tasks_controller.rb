class TasksController < ApplicationController
  
  def index
    @task = Task.all
  end
  
  def new
  end
  
end
