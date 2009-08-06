class ArticlesController < ApplicationController
  
  before_filter :load_access_token
  
  def index
    @articles = Article.find(:all, :account_id => 7, :page => 5, :as => @access_token) + Article.find(:all, :account_id => 13, :as => @access_token) + Article.find(:all, :account_id => 4, :as => @access_token)
    @articles = @articles.sort_by{|article| article.published_at }.reverse
    
    @pick_ups = PickUp.find_all_by_owner_article_id(@articles.map { |a| a.id }).map { |pu| pu.owner_article_id}
  end
  
  def show
    @article = Article.find(params[:id], :account_id =>params[:account_id],  :as => @access_token)
  end

end
