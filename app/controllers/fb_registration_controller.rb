class FbRegistrationController < ApplicationController
	@@colleges = ["stanford", "harvard", "yale", "princeton"]
	
  def FbLogin
  end

  def Login
  end
	
	def ValidCollegeEmail(email)
		array = email.split('@')
		if array.length != 2
			return false
		end
		
		dot = array[1].split('.')
		
		if dot.length != 2
			return false
		end
		
		college = dot[0]
		
		@@colleges.each do |c|
			if c.eql?(college)
				return true
			end	
		end
		
		return false
	end
	
	def GetSchool(email)
		college = email.split('@')[1].split('.')[0]
		college.capitalize!
		return college
	end
	
	def RegisterUser
		secret = "377aecb43717e1dc8bd78a803c1448a0"
		facebook = FacebookRegistration::SignedRequest.parse(params["signed_request"], secret)
		fields = facebook["registration"]
		
		if !ValidCollegeEmail(fields["email"])
			redirect_to :action => "FbLogin", :efail => true
			return
		end

		profile = Profile.new
		
		File.open(Rails.root.join('public/images/default-profile-pic.png')) do |pic|
			profile.file_name = "Default Pic"
            profile.file_type = nil
            profile.size = nil
			
            profile.data = pic.read
			profile.School = GetSchool(fields["email"]) #test
			profile.save
		end
		


		u = User.new
		u.name = fields["name"]
		u.email = fields["email"]
		u.password = fields["password"]
		u.profile_id = profile.id
		u.save

		redirect_to :action=> "Remember", :user => u.email, :pass => u.password

	end

	def Remember
		email = params[:user]
		pass = params[:pass]
		
		u = User.where({:email => email, :password => pass})
		if u.length == 0
			redirect_to "/fb_registration/Login"
		else
			u = u[0]
			cookies[:name] = u.name
			cookies[:email] = u.email
			cookies[:pass] = u.password
			redirect_to "/"
		end
	end

	def Logout
		cookies.delete :name
		cookies.delete :email
		cookies.delete :pass
		redirect_to "/"
	end

end
