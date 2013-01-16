class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :authorizeAdmin
  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
              session[:user_id] = user.id
              session[:user_name] = user.name
              session[:user_aut] = user.authenticity
              redirect_to posts_url
              else
                redirect_to sessions_url, :alert => "Invalid user/password combination"
                end
  end

  def destroy
    #session[:user_id] = nil
    session[:user_id] = nil
    session[:user_name]=nil
    session[:user_aut]=nil
    redirect_to sessions_url, :notice => "Logged out"
  end

end
