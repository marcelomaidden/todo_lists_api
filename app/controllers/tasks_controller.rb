class TasksController < ApplicationController

  def index
    @tasks = Task.all

    json = []
    @tasks.each do |task|
      json << {"title": task.title, "completed" task.completed}
    end

    render json: json
  end

  def uncompleted_tasks
    @tasks = Task.all.where(completed: false)

    json = []
    @tasks.each do |task|
      json << {"title": task.title, "completed" task.completed}
    end

    render json: json
  end

  def completed_tasks
    @tasks = Task.all.where(completed: true)

    json = []
    @tasks.each do |task|
      json << {"title": task.title, "completed" task.completed}
    end

    render json: json
  end

  def show
    @task = Task.find(params[:id])
    render json: {"title": @task.title, "completed" @task.completed}
  end

  def create
    @task = Task.new(params[:task])

    if @task.save
      render json: {"title": @task.title, "completed" @task.completed}
    else
      render json: @task.errors
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(params[:task])
      render json: {"title": @task.title, "completed" @task.completed}
    else
      render json: @task.errors
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end


end
