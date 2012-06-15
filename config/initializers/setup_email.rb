ActionMailer::Base.smtp_settings = {
    #:address => "127.0.0.1", 
	:address              => "smtp.gmail.com",
    #:port => 25,
	:port => 587,
	#:domain               => "domain.pl",
    #:user_name => "noreply", 
	:user_name => "noreplyvidactica",
	#:password => "jS;v0Uf/#@oLKiE<y",
	:password => "vidactica321",
	:authentication       => "plain",
	:enable_starttls_auto => true
}
