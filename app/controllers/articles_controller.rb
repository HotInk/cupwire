class ArticlesController < ApplicationController
  
  before_filter :load_access_token
  
  def index
    @articles = Article.find(:all, :account_id => 7, :as => @access_token)
    @pick_ups = PickUp.find_all_by_owner_article_id(@articles.map { |a| a.id })
  end
  
  def show
    @article = Article.find(params[:id], :account_id =>7,  :as => @access_token)
  end

end
