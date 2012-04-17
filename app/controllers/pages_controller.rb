class PagesController < ApplicationController
	
  def home
    @title = "Home"
  end

  def bio
    @title = "Bio"
    u = User.where({:email => cookies[:email], :password => cookies[:pass]})
    @user = u[0]
    @profile = @user.profile
      #send_data @profile.data, :type => 'image/png', :disposition => 'inline'
  end
    
  def show_image
      user = User.find(params[:id])
      profile = user.profile
      send_data profile.data, :type => 'image/png' #, :disposition => 'inline'      
  end
      
  def editBio
    @title = "Edit"
  end
  
  def ask
	@saved = Rails.cache.read("saved")
    @title = "Ask For Advice"
  end
  
  def give
	@cat = Rails.cache.read("Category")
	@questions = Question.where(:category => @cat)
    @title = "Provide Words of Wisdom"
  end
  
  def watch
    @title = "View Top Video Sessions"
  end

	def submitQuestion
		q = Question.new
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})

		if u.length == 0
			q.user_id = -1
		else
			u = u[0]
			q.user_id = u.id
		end
		q.question = params[:question]
		q.category = Integer(params[:category])
		save = q.save
		Rails.cache.write("saved", save)
		redirect_to "/tok/AskChatRoom"
	end

	def submitProfile
		u = User.where({:email => cookies[:email], :password => cookies[:pass]})
		u = u[0]
		profile = u.profile

        pic = params[:profile][:picture]
        
        if(pic != nil)
            profile.file_name = pic.original_filename
            profile.file_type = pic.content_type
            profile.size = pic.size

            profile.data = pic.read
            
            #profile.image_file(params[:profile][:picture])
        else
            profile.file_name = ""
            profile.file_type = ""
            profile.size = 0
            
            profile.data = nil
        end
		profile.blurb = params[:profile][:blurb]
		profile.save

		redirect_to "/bio"
	end

	def getCategory
		Rails.cache.write("Category", Integer(params[:category]))
		redirect_to "/give"
	end



end
