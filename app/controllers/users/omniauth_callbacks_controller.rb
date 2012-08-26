class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
		super
		puts failure_message
	end
	
	def passthru
		render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
		# Or alternatively,
		# raise ActionController::RoutingError.new('Not Found')
	end

end