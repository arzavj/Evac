class RegistrationsController < Devise::RegistrationsController

	def create
		build_resource
		
		if resource.save
			if resource.active_for_authentication?
				set_flash_message :notice, :signed_up if is_navigational_format?
				sign_in(resource_name, resource)
				respond_with resource, :location => after_sign_up_path_for(resource)
				return
			else
				expire_session_data_after_sign_in!
				respond_with resource, :location => after_inactive_sign_up_path_for(resource)
				return
			end
			flash[:notice] = "Please check your email."
		else
			clean_up_passwords resource
			flash[:error] = "Please fill out your registration form properly"
			redirect_to "/"
		end
	end

protected	
	
	def after_inactive_sign_up_path_for(resource)
		return "/"
	end
	
end 