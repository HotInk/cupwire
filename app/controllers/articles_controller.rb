class ArticlesController < ApplicationController
  
  before_filter :load_access_token
  
  def index
    @articles = Article.find(:all, :account_id => 7, :as => @access_token)
  end
  
  def show
    @article = Article.find(params[:id], :account_id =>7,  :as => @access_token)
  end

end
