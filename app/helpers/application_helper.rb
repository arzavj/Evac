module ApplicationHelper
	def current_account
		return User.where({:email => cookies[:email], :password => cookies[:pass]}).first
	end 
end
