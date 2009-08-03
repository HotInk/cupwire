class ArticlesController < ApplicationController
  
  before_filter :load_access_token
  
  def index
    @numba = params[:id] if params[:id]
    @articles = Article.find(:all, :as => @access_token)
  end
  
  def show
    @article = Article.find(params[:id], :as => @access_token)
  end

end
