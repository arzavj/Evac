# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Vidactica::Application.initialize!

	$apiKey = "13568632"
	$apiSecret = "576b22cb7f0415a60bba7e9829fbb3739375ded6"
	$opentok = OpenTok::OpenTokSDK.new $apiKey, $apiSecret 
