ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",
	:port                 => 587,
	#:domain               => "domain.pl",
	:user_name            => "noreplyvidactica",
	#:password             => "V28K!k7]N(GUh2M/A", #for noreply@vidactica.com
	:password             => "vidactica321",
	:authentication       => "plain",
	:enable_starttls_auto => true
}
