class Public::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    
    if @range == "user"
      @users = User.search(params[:search], params[:keyword])
    elsif @range == "article"
      @articles = Article.search(params[:search], params[:keyword])
    else @range = "tag"
      @tags = Tag.search(params[:search], params[:keyword])
    end
    
  end
  
end
