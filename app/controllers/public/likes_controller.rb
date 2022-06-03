class Public::LikesController < ApplicationController
  
  def create
    @article = Article.find(params[:article_id])
    @like = current_user.likes.new(article_id: @article.id)
    @like.save
    redirect_to request.referer
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @like = current_user.likes.find_by(article_id: @article.id)
    @like.destroy
    redirect_to request.referer
  end
end