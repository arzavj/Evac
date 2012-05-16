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
		
		#@@colleges.each do |c|
		#	if c.eql?(college)
		#		return true
		#		end	
		#end
		
		return false
		
		
		return true
	end
	
	def GetSchool(email)
		college = email.split('@')[1].split('.')[0]
		college.capitalize!
		return college
	end
	
	def random_alphanumeric(size)
		s = ""
		size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
		return s
	end
	
	def NewUser
		user = User.find(params["uID"])
		if user.verify.eql?("Clear")
			redirect_to	"/"
			return
		end	
		
		if params["verify"].eql?(user.verify)
			user.verify = "Clear"
			user.save
			VidMail.Welcome(user.id).deliver #send email
			redirect_to	:action=>"Remember", :user => user.email, :pass => user.password
			return
		end
		
		redirect_to "/"
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
		u.verify = random_alphanumeric(Kernel.rand(16)+16)
		u.save
		
		VidMail.ConfirmEmail(u.id).deliver #send email

		redirect_to :controller=>"pages", :action=> "home", :email => "1"

	end

	def Remember
		email = params[:user]
		pass = params[:pass]
		
		u = User.where({:email => email, :password => pass})
		if u.length == 0
			redirect_to :action => "Login", :fail => "1"
			return
		else
			u = u[0]
			if !u.verify.eql?("Clear")
				redirect_to :action=> "Login", :verify => "1"
				return
			end
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
