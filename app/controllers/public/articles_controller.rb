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
    tag_list = params[:article][:tag_name].split(nil)
    if params[:post]
      if @article.save(context: :publicize)
        @article.save_tag(tag_list)
        redirect_to articles_path, notice: "記事を投稿しました！"
      else
        @articles = Article.all
        render "new"
      end
    else
      if @article.update(is_draft: true)
        redirect_to user_path(current_user), notice: "下書きに保存しました！"
      else
        render "new"
      end
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if params[:publicize_draft]
      @article.attributes = article_params.merge(is_draft: false)
      if @article.save(context: :publicize)
        redirect_to article_path(@article), notice: "下書きを公開しました！"
      else
        @article.is_draft = true
        render "edit"
      end
    elsif params[:update_post]
      @article.attributes = article_params
      if @article.save(context: :publicize)
        redirect_to article_path(@article), notice: "投稿を更新しました！"
      else
        render "edit"
      end
    else
      if @article.update(article_params)
        redirect_to article_path(@article), notice: "下書きを更新しました！"
      else
        render "edit"
      end
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body, :is_draft, :image)
  end
  
  def correct_user
    @article = Article.find(params[:id])
    @user = @article.user
    redirect_to(articles_path) unless @user == current_user
  end
end
