class TasksController < ApplicationController
  def index
    @tasks = Task.from_user(current_user.id)

    render json: { tasks: @tasks }
  end

  def create
    @task = Task.new(task_params.merge({ user_id: current_user.id }))

    if @task.save
      render json: { status: "success", task: @task }
    else
      render json: { status: "error", errors: @task.errors }
    end

  rescue ArgumentError => e
    render json: { status: "error", errors: e }
  end

  private

  def task_params
    params.require(:task).permit(:title, :status)
  end
end
