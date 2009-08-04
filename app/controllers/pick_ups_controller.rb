class PickUpsController < ApplicationController

  before_filter :load_access_token
  
  def new
    @pick_up = PickUp.new(:owner_article_id => params[:owner_article_id], :owner_account_id => params[:owner_account_id])
    @article = Article.find params[:owner_article_id], :account_id => params[:owner_account_id], :as => @access_token
    respond_to do |format|
      format.js
    end
  end

  def create
    @pick_up = PickUp.new(params[:pick_up])
    article = Article.find @pick_up.owner_article_id.to_i, :account_id => @pick_up.owner_account_id, :as => @access_token
    @article = Article.new( :title => article.title, :subtitle => article.subtitle, :authors_list => article.authors_list, :bodytext => article.bodytext, :created_at => (Time.parse(article.published_at) || (Time.now - 2.seconds)).to_formatted_s(:db) )
    @article.access_token = @access_token
    @article.account_id = 1
    if @article.save
      @pick_up.wire_article_id = @article.id
      @pick_up.save
      flash[:notice] ="Article picked up successfully!"
      redirect_to root_url
    else
      flash[:notice] = "Article NOT PICKED UP (Oh no, an error!)"
    end
  end

end
