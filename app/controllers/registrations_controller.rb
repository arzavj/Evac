class RegistrationsController < Devise::RegistrationsController
	def new
		redirect_to "/"
	end
	
	def create
		super
	end
	
	def update
		super
	end
end 