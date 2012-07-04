require 'test/unit'
require 'facebook_registration'

class FacebookRegistrationSignedRequestTest < Test::Unit::TestCase
  def test_signed_request_is_initialized
		assert FacebookRegistration::SignedRequest
  end
	
	def test_parse_should_raise_error_for_missing_secret_key
		begin
      FacebookRegistration::SignedRequest.parse({:signed_request => "vlXgu64BQGFSQrY0ZcJBZASMvYvTHu9GQ0YM9rjPSso.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsIjAiOiJwYXlsb2FkIn0"})
    rescue Exception => e
    assert_equal "Missing Facebook secret key", e.message
    end
	end
	
	def test_parse_should_raise_error_for_missing_signed_request
		#Testing for missing value
		begin
      FacebookRegistration::SignedRequest.parse({:invalid_key => "some-dummy-data"}, 'valid-secret-key')
    rescue Exception => e
			assert_equal "Missing signed_request param", e.message
		end
		
		#Testing for invalid key
		begin
      FacebookRegistration::SignedRequest.parse({:signed_request => "some-dummy-data"}, 'valid-secret-key')
    rescue Exception => e
			assert_equal "Invalid signature", e.message
    end
	end
	
	# TODO - Missing Success TestCases
	# We need some valid signed_request parameter from facebook to test the remaining functionalities.
	# So here we test only failure test cases.
	
end