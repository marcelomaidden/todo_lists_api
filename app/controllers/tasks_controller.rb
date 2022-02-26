class TasksController < ApplicationController
  before_action :load_task, only: %i[show update complete uncomplete destroy]
  before_action :load_tasks, only: %i[index completed uncompleted]

  def index
    render json: { tasks: @tasks }
  end

  def show
    return render json: { task: @task } if @task.present?

    not_found
  end

  def completed
    render json: { tasks: @tasks.completed }
  end

  def uncompleted
    render json: { tasks: @tasks.uncompleted }
  end

  def complete
    render json: { status: "success", message: @task.completed! }
  end

  def uncomplete
    render json: { status: "success", message: @task.uncompleted! }
  end

  def update
    return not_found unless @task.present?

    return render_error(@task.errors) unless @task.update(task_params)

    render json: { task: @task }
  rescue ArgumentError => e
    render_error(e)
  end

  def create
    @task = Task.new(task_params.merge({ user_id: current_user.id }))

    return render_error(@task.errors) unless @task.save

    render json: { status: "success", task: @task }
  rescue ArgumentError => e
    render_error(e)
  end

  def destroy
    return render_error(@task.errors) unless @task.delete

    render json: { status: "success", message: "Task deleted" }
  end

  private

  def load_tasks
    @tasks = Task.from_user(current_user.id)
  end

  def load_task
    @task = Task.find(params[:id])

    return if from_user?

    return render_error("Unauthorized")
  rescue ActiveRecord::RecordNotFound
    render_error("Task not found")
  end

  def from_user?
    @task.user_id == current_user.id
  end

  def task_params
    params.require(:task).permit(:title, :status)
  end
end
