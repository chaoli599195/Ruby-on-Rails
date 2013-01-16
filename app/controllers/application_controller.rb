class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :authorizeAdmin
  protect_from_forgery




  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to(login_url, :alert => 'Please log in')
      end
  end

  def authorizeAdmin
    if session[:user_aut].to_s=='0'

      redirect_to posts_url, :notice=> "You don not have the authenticity to do"

    end



  end



end
