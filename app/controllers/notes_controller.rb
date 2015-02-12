class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]

    @note.save
    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])

    if current_user.id == @note.user_id
      @note.destroy!
      redirect_to track_url(@note.track_id)
    else
      render text: "Illegal request", status: 403
    end
  end

  private
    def note_params
      params.require(:note).permit(:content)
    end
end
