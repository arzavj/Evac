class FacebookCallbacksController < ApplicationController
	def facebook
	#You need to implement the method below in your model
		@user= User.find_for_facebook_oauth(request.env["omniauth.auth"],current_user)
		if @user.persisted?
			flash[:notice] = I18n.t"devise.omniauth_callbacks.success", :kind=>"Facebook"
			sign_in_and_redirect @user, :event=>:authentication
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			flash[:error] = "Authentication failed"
			redirect_to root_url
		end
	end
	
	def failure
		set_flash_message :error, :failure, :kind => OmniAuth::Utils.camelize(failed_strategy.name), :reason => failure_message
		redirect_to root_url
	end

end