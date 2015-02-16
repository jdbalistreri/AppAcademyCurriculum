class CommentsController < ApplicationController

  def create
    type = params[:commentable][:type]
    @commentable = type.constantize.find(params[:commentable][:id])
    comment = @commentable.comments.new(comment_params)
    comment.author_id = current_user.id

    unless comment.save
      flash[:errors] = comment.errors.full_messages
    end

    redirect_to self.send("#{type.downcase}_url", @commentable)

  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
