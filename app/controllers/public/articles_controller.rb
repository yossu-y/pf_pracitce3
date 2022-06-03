class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end
  
  def index
    @articles = Article.all
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
    @articlenew = Article.new
    @comment = Comment.new
  end
  
  def create
    @article = current_user.articles.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path
    else
      @articles = Article.all
      render "new"
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
  def correct_user
    @article = Article.find(params[:id])
    @user = @article.user
    redirect_to(articles_path) unless @user == current_user
  end
end
