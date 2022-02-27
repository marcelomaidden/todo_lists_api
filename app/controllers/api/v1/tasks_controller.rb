class Api::V1::TasksController < Api::V1::BaseTaskController
  before_action :load_task, only: %i[show update complete uncomplete destroy]
  before_action :load_tasks, only: %i[index completed uncompleted]

  def index
    render_success(tasks: @tasks)
  end

  def show
    return render_success(task: @task) if @task.present?

    not_found
  end

  def completed
    render_success(tasks: @tasks.completed)
  end

  def uncompleted
    render_success(tasks: @tasks.uncompleted)
  end

  def complete
    render_success(message: @task.completed!)
  end

  def uncomplete
    render_success(message: @task.uncompleted!)
  end

  def update
    return not_found unless @task.present?

    return render_bad_request(@task.errors) unless @task.update(task_params)

    render_success(task: @task)
  rescue ArgumentError => e
    render_bad_request(e)
  rescue ActionController::ParameterMissing
    render_bad_request('Parameter description is missing')
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))

    return render_error(@task.errors) unless @task.save

    render_success(task: @task)
  rescue ArgumentError => e
    render_bad_request(e)
  rescue ActionController::ParameterMissing
    render_bad_request('Parameter description is missing')
  end

  def destroy
    return render_bad_request(@task.errors) unless @task.delete

    render_success(message: 'Task deleted')
  end

  private

  def load_tasks
    @tasks = Task.from_user(current_user.id)
  end

  def task_params
    params.require(:task).permit(:title, :status)
  end
end
