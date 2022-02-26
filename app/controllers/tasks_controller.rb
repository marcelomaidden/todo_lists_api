class TasksController < ApplicationController
  before_action :load_task, only: %i[show update]

  def index
    @tasks = Task.from_user(current_user.id)

    render json: { tasks: @tasks }
  end

  def show
    return render json: { task: @task } if @task.present?

    render json: { status: "error", message: "Task not found" }
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

  def load_task
    @task = Task.find(params[:id])

    return if from_user?

    @task = nil
  rescue ActiveRecord::RecordNotFound
    render json: { status: "error", message: "Task not found" }
  end

  def from_user?
    @task.user_id == current_user.id
  end

  def task_params
    params.require(:task).permit(:title, :status)
  end
end
