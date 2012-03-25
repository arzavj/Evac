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
	end

	def Remember
		user = params[:user]
		pass = params[:pass]
		
		u = User.where({:email => user, :password => pass})
		if u
			redirect_to "/fb_registration/Login"
		else
			cookies[:name] = u.name
			cookies[:email] = u.email
			cookies[:pass] = u.password
			redirect_to "/"
		end
	end

end
