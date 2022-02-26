class TasksController < ApplicationController

  def index
    @tasks = Task.from_user(current_user.id)

    render json: { tasks: @tasks }
  end
end
