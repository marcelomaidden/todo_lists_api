class BaseTaskController < ApplicationController
  protected

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
end
