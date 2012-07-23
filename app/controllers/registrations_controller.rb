class RegistrationsController < Devise::RegistrationsController

	def create
		build_resource
		
		self.resource.profile_id = new_profile
		
		if resource.save
			if resource.active_for_authentication?
				set_flash_message :notice, :signed_up if is_navigational_format?
				sign_in(resource_name, resource)
				respond_with resource, :location => after_sign_up_path_for(resource)
			else
				expire_session_data_after_sign_in!
				respond_with resource, :location => after_inactive_sign_up_path_for(resource)
			end
		else
			clean_up_passwords resource
			flash[:error] = "Please fill out your registration form properly"
			redirect_to "/"
		end
	end

protected	
	
	def after_inactive_sign_up_path_for(resource)
		flash[:email] = "set"
		return "/"
	end
	
	def new_profile
		profile = Profile.new
		
		File.open(Rails.root.join('public/images/default-profile-pic.png')) do |pic|
			profile.file_name = "Default Pic"
            profile.file_type = nil
            profile.size = nil
			
            profile.data = pic.read
			#profile.School = GetSchool(fields["email"]) #test
			profile.save
		end

		return profile.id
	end
end 