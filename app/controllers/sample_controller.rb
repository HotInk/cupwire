class SampleController < ApplicationController
  
  before_filter :load_access_token
  
  def show
    @numba = params[:id] if params[:id]
    @articles = @access_token.get('http://0.0.0.0:3000/accounts/1/articles.xml')
  end

end
