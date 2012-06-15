ActionMailer::Base.smtp_settings = {
    :address => "vidactica.com", 
	#:address => "smtp.gmail.com",
    :port => 25,
	#:port => 587,
	#:domain               => "domain.pl",
    :user_name => "noreply@vidactica.com", 
	#user_name => "noreplyvidactica",
	#:password => "g%T^)wnA2ws8/Y+-$",
	:password => "%pN5AJUf@mG/0r;mB",
	:openssl_verify_mode => 'none',
	#:password => "vidactica321",
	:authentication       => "plain"
	#:enable_starttls_auto => true
}
