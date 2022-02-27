class Api::V1::NotesController < Api::V1::BaseTaskController
  before_action :load_task, only: %i[index create]
  before_action :load_note, only: %i[show update destroy]

  def index
    render_success(notes: @task.notes)
  end

  def show
    render_success(note: @note)
  end

  def create
    @note = Note.new(note_params.merge(task_id: @task.id))

    return render_bad_request(@note.errors) unless @note.save

    render_success(note: @note)
  rescue ActionController::ParameterMissing
    render_bad_request('Parameter description is missing')
  end

  def update
    return not_found unless @note.present?

    return render_bad_request(@note.errors) unless @note.update(note_params)

    render_success(note: @note)
  rescue ArgumentError => e
    render_bad_request(e)
  rescue ActionController::ParameterMissing
    render_bad_request('Parameter description is missing')
  end

  def destroy
    return render_bad_request(@note.errors) unless @note.delete

    render_success(message: 'Note deleted')
  end

  private

  def load_note
    @note = Note.find(params[:id])

    return if from_user?(@note.task)

    render_error('Unauthorized')
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def note_params
    params.require(:note).permit(:description)
  end
end
