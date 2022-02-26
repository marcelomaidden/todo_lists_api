class NotesController < BaseTaskController
  before_action :load_task, only: %i[index show create]

  def index
    render json: { status: "success", notes: @task.notes }
  end

  def show
  end

  def create
    @note = Note.new(note_params.merge({ task_id: @task.id }))

    return render_error(@note.errors) unless @note.save

    render json: { status: "success", note: @note }
  end

  def update
  end

  def destroy
  end

  private

  def note_params
    params.require(:note).permit(:description)
  end
end
