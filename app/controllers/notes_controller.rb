class NotesController < BaseTaskController
  before_action :load_task, only: %i[index create]
  before_action :load_note, only: %i[show update destroy]

  def index
    render json: { status: "success", notes: @task.notes }
  end

  def show
    render json: { status: "success", note: @note }
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

  def load_note
    @note = Note.find(params[:id])

    return if from_user?(@note.task)

    return render_error("Unauthorized")
  rescue ActiveRecord::RecordNotFound
    render_error("Note not found")
  end

  def note_params
    params.require(:note).permit(:description)
  end
end
