class ArticlesController < ApplicationController
    before_action :set_article, only: [ :show, :edit, :update, :destroy ]

    def show
        # debugger
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit

    end

    def create
        #  render plain: params[:article]
        @article = Article.new(article_params)
        if @article.save
            flash[:notice] = "Article was created successfully."
            # redirect_to article_path(@article) #shortcut is -->
            redirect_to @article
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        # link_to does not work for destroy method, instead you have to use button_to 
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end
end