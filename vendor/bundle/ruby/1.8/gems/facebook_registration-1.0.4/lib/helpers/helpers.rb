module FacebookRegistrationHelper
  def self.included(base)
    base.send :include, InstanceMethods
  end
  
    
  module InstanceMethods
  DefaultValues = {"fields" =>"name,email,password", "redirect-uri"=>"http://localhost:3000/fb_registration", "fb_only" => false, "width" => "100%", "height" => nil, "onvalidate" =>nil}
  
  def init_fb_registration(app_id=nil)
    raise "Must set Application ID for initializing" unless app_id
    "<div id=\"fb-root\"></div> \n <script src=\"http://connect.facebook.net/en_US/all.js#appId=#{app_id}&xfbml=1\"></script> \n <script src=\"http://code.jquery.com/jquery-1.4.4.min.js\"></script>"
  end
  
  def fb_registration_form(options={})
    options = DefaultValues.merge(options).delete_if { |key, value| value.nil? }
    
    str = "<fb:registration"
    options.each_pair do |key, value|
      str += " #{key} = \"#{value}\""
    end
    str += "> </fb:registration>"
  end
end


end

ActionView::Base.send(:include, FacebookRegistrationHelper) if defined?(ActionView::Base)

