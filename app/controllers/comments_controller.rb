class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype #生成されたコメントを有するprototypeを再定義
      @comments = @prototype.comments #prototypeに紐ついたcommentsを定義
      render "prototypes/show"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
  
end
