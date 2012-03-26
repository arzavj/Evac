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
		if u.save
			redirect_to "/"
		else
			redirect_to "fb_registration/FbLogin"
		end
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
