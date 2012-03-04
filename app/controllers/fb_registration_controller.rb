class FbRegistrationController < ApplicationController
  def FbLogin
  end

	def RegisterUser
		para = call(params)
		u = User.new
		u.name = para.parse(:name)
		
		redirect_to "/index"
	end

end
