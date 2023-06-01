class ArticlesController < ApplicationController
    before_action :set_article, only: [ :show, :edit, :update, :destroy ]
    before_action :require_user, except: [ :show, :index ]
    before_action :require_same_user, only: [ :edit, :update, :destroy ]

    def show
        # debugger
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 3)
    end

    def new
        @article = Article.new
    end

    def edit

    end

    def create
        #  render plain: params[:article]
        @article = Article.new(article_params)
        @article.user = current_user
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
        params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end