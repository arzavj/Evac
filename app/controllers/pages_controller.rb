class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def bio
    @title = "Bio"
  end
  
  def ask
    @title = "Ask For Advice"
  end
  
  def give
    @title = "Provide Words of Wisdom"
  end
  
  def watch
    @title = "View Top Video Sessions"
  end

end
