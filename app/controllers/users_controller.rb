class UsersController < ApplicationController
  
  skip_before_filter :require_user, :only => :new
  
  # A "new user" in this context is really just a OAuth request token until we get that token approved, then we can create the user.
  def new
    if params[:oauth_token]
      token = OauthToken.find_by_token(params[:oauth_token], :conditions => { :token_type => "RequestToken"} )
      request_token = OAuth::RequestToken.new(get_consumer, token.token, token.secret)
      access_token = request_token.get_access_token
      @token = OauthToken.new(:token => access_token.token, :secret => access_token.secret, :token_type => "AccessToken" )
      @user = User.create!(:oauth_token => @token )
      if params[:request_url] # preserve a passed along request url
        redirect_to params[:request_url]
      else
        redirect_to root_url
      end
    else  
      consumer = get_consumer
      request_token = consumer.get_request_token
      @token = OauthToken.create!(:token => request_token.token, :secret => request_token.secret, :token_type => "RequestToken")
      if @token
        if params[:request_url] # preserve a passed along request url
          redirect_to request_token.authorize_url + "&request_url=#{params[:request_url]}"
        else
          redirect_to request_token.authorize_url
        end
      end
    end
  end

  
end
