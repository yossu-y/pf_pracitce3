class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end
  
  def index
    @articles = Article.all
    @article = Article.new
    @tag_list = Tag.all
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list=@article.tags.pluck(:name).join('#')
  end

  def show
    @article = Article.find(params[:id])
    @articlenew = Article.new
    @comment = Comment.new
    @article_tags = @article.tags
  end
  
  def create
    @article = current_user.articles.new(article_params)
    @article.user_id = current_user.id
    tag_list = params[:article][:tag_name].split(nil)
    if @article.save
      @article.save_tag(tag_list)
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
