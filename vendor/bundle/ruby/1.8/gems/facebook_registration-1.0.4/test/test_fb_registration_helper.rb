require 'test/unit'
require 'facebook_registration'
include FacebookRegistrationHelper

class FacebookRegistrationTest < Test::Unit::TestCase
  def test_default_values_is_defined
    assert defined? DefaultValues
  end
  
  def test_default_values_assignment
    assert_equal "name,email,password",  DefaultValues["fields"]
    assert_equal "http://localhost:3000/fb_registration",  DefaultValues["redirect-uri"]
    assert_equal false,  DefaultValues["fb_only"]
  end
  
  def test_init_fb_registration_should_raise_error
    begin
      init_fb_registration
    rescue Exception => e
    assert_equal "Must set Application ID for initializing", e.message
    end
  end
  
  def test_init_fb_registration_should_not_through_error_for_valid_input
    assert init_fb_registration('some-api-key')
  end
  
  def test_init_fb_registration_should_return_fb_scripts
    fb_scripts = init_fb_registration('some-api-key')
    assert_match /<div id="fb-root"><\/div>/, fb_scripts
    assert_match /http:\/\/connect.facebook.net\/en_US\/all.js#appId=some-api-key/, fb_scripts
  end
  
  def test_fb_registration_form_should_return_fb_registration_tags
    form_text = fb_registration_form
    assert_match /<fb:registration/, form_text
    assert_match /<\/fb:registration>/, form_text
  end
  
  def test_fb_registration_form_should_use_default_values
    form_text = fb_registration_form
    assert_match /fields = "#{DefaultValues["fields"]}"/, form_text
    assert_match /fb_only = "#{DefaultValues["fb_only"]}"/, form_text
  end
  
  def test_fb_registration_form_should_use_passed_values_instead_of_default_values
    form_text = fb_registration_form("redirect-uri" => "http://test.localhost.com/fb_signup", "fb_only" => true)
    assert_match /fb_only = "true"/, form_text
    assert_match /redirect-uri = "http:\/\/test.localhost.com\/fb_signup"/, form_text
  end
end