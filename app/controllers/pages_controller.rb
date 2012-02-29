class PagesController < ApplicationController
	
  def home
    @title = "Home"
  end

  def bio
    @title = "Bio"
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

end
