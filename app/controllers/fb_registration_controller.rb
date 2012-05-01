class FbRegistrationController < ApplicationController
  def FbLogin
  end

  def Login
  end

	def RegisterUser
		secret = "377aecb43717e1dc8bd78a803c1448a0"
		facebook = FacebookRegistration::SignedRequest.parse(params["signed_request"], secret)
		fields = facebook["registration"]

		File.open("/public/images/profile_icon.png", "r") do |pic|
			profile = Profile.new
			profile.file_name = pic.original_filename
            profile.file_type = pic.content_type
            profile.size = pic.size
			
            profile.data = pic.read
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
