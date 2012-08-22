class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
	#You need to implement the method below in your model
		@user= User.find_for_facebook_oauth(request.env["omniauth.auth"],current_user)
		
		#flash[:notice] = I18n.t"devise.omniauth_callbacks.success", :kind=>"Facebook"
		#sign_in_and_redirect @user, :event=>:authentication

	end
	
	def passthru
		render :file=>"#{Rails.root}/public/404.html", :status=>404, :layout=>false
	end
end