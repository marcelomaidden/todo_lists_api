class NotesController < BaseTaskController
  before_action :load_task, only: %i[index create]
  before_action :load_note, only: %i[show update destroy]

  def index
    render json: { status: 'success', notes: @task.notes }
  end

  def show
    render json: { status: 'success', note: @note }
  end

  def create
    @note = Note.new(note_params.merge(task_id: @task.id))

    return render_error(@note.errors) unless @note.save

    render json: { status: 'success', note: @note }
  rescue ActionController::ParameterMissing
    render_error('Parameter description is missing')
  end

  def update
    return not_found unless @note.present?

    return render_error(@note.errors) unless @note.update(note_params)

    render json: { note: @note }
  rescue ArgumentError => e
    render_error(e)
  rescue ActionController::ParameterMissing
    render_error('Parameter description is missing')
  end

  def destroy
    return render_error(@note.errors) unless @note.delete

    render json: { status: 'success', message: 'Note deleted' }
  end

  private

  def load_note
    @note = Note.find(params[:id])

    return if from_user?(@note.task)

    render_error('Unauthorized')
  rescue ActiveRecord::RecordNotFound
    render_error('Note not found')
  end

  def note_params
    params.require(:note).permit(:description)
  end
end
