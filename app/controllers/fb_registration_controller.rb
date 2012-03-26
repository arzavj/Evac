class FbRegistrationController < ApplicationController
  def FbLogin
  end

  def Login
  end

	def RegisterUser
		u = User.new
		u.name = params[:name]
		u.email = params[:email]
		u.password = params[:password]
		u.save
		redirect_to "/"
		
		secret = "377aecb43717e1dc8bd78a803c1448a0";
	
		facebook = FacebookRegistration::SignedRequest.parse(params["signed_request"], secret)
		puts facebook
	end

	def Remember
		user = params[:user]
		pass = params[:pass]
		
		u = User.where({:email => user, :password => pass})
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
