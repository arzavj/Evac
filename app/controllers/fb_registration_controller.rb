class FbRegistrationController < ApplicationController
  def FbLogin
  end

	def RegisterUser
		u = User.new
		u.name = params[:name]
		u.email = params[:email]
		u.password = params[:password]

		redirect_to "/"
	end

end
