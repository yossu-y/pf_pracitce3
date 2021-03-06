class Public::CommentsController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = article.id
    @comment.save
    article.create_notification_comment!(current_user, @comment.id)
    # redirect_to request.referer
  end
  
  def destroy
    @comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    @comment.destroy
    # redirect_to request.referer
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
