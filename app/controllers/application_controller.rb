class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
	
  before_filter :require_login	
	
  def require_login
	  if cookies["name"].nil?
		  redirect_to "/"
	  end
  end
	
end
