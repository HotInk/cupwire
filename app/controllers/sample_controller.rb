class SampleController < ApplicationController
  
  before_filter :load_access_token
  
  def show
    @numba = params[:id] if params[:id]
    @articles = @access_token.get(OAUTH_CREDENTIALS[:site] + '/accounts/7/articles.xml')
  end

end
