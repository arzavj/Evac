ActionMailer::Base.smtp_settings = {
    :address => "mail.vidactica.com", 
	#:address => "smtp.gmail.com",
    :port => 25,
	#:port => 587,
	#:domain               => "domain.pl",
    :user_name => "noreply@vidactica.com", 
	#user_name => "noreplyvidactica",
	#:password => "g%T^)wnA2ws8/Y+-$",
	:password => "jS;v0Uf/#@oLKiE<y",
	#:password => "vidactica321",
	#:authentication       => "plain",
	#:enable_starttls_auto => true
}
