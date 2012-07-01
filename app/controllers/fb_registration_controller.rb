class FbRegistrationController < ApplicationController
  skip_before_filter :require_login
	
	@@colleges = ["stanford", "harvard", "yale", "princeton"]
	
  def FbLogin
  end

  def Login
  end
	
	def Registration
	end
		
	def ValidCollegeEmail(email)
		array = email.split('@')
		if array.length != 2
			return false
		end
		
		#dot = array[1].split('.')
		
		#college = dot[0]
		
		#@@colleges.each do |c|
		#	if c.eql?(college)
		#		return true
		#		end	
		#end
		
		#return false
		
		
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
	
	def RegisterUser #from facebook
		secret = "c1576820bcca019f62bc630e457b0713"
		facebook = FacebookRegistration::SignedRequest.parse(params["signed_request"], secret)
		fields = facebook["registration"]
		
		if User.where(:email => fields["email"]).length != 0
			redirect_to :action => "FbLogin", :exist => true
			return
		end
		
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
		u.firstName = fields["first_name"]
		u.lastName = fields["last_name"]
		u.email = fields["email"]
		u.password = fields["password"]
		u.profile_id = profile.id
		u.verify = random_alphanumeric(Kernel.rand(16)+16)
		u.save
		
		VidMail.ConfirmEmail(u.id).deliver #send email

		redirect_to :controller=>"pages", :action=> "home", :email => "1"

	end
	
	def SaveUser
	
		if !params["password"].eql?(params["passwordAgain"]) 
			redirect_to :action => "Registration", :pfail => true, :name => params["name"], :email => params["email"]
			return
		end
		
		if User.where(:email => params["email"]).length != 0
			redirect_to :action => "Registration", :exist => true, :name => params["name"], :email => params["email"]
			return
		end
		
		if !ValidCollegeEmail(params["email"])
			redirect_to :action => "Registration", :efail => true, :fname => params["fname"], :lname => params["lname"], :email => params["email"]
			return
		end
		
		profile = Profile.new
		
		File.open(Rails.root.join('public/images/default-profile-pic.png')) do |pic|
			profile.file_name = "Default Pic"
            profile.file_type = nil
            profile.size = nil
			
            profile.data = pic.read
			profile.School = GetSchool(params["email"]) #test
			profile.save
		end
		
		u = User.new
		u.firstName = params["fname"]
		u.lastName = params["lname"]
		u.email = params["email"]
		u.password = params["password"]
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
			redirect_to :controller => "pages", :action => "home", :fail => "1"
			return
		else
			u = u[0]
			if !u.verify.eql?("Clear")
				redirect_to :controller => "pages", :action => "home", :verify => "1"
				return
			end
			cookies[:name] = u.firstName
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
