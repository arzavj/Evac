class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
	
	before_filter :authenticate_user!
	
	def ADMIN!
		return redirect_to root_url if !current_user.admin?
	end
	
end
