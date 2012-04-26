ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",
	:port                 => 587,
	#:domain               => "domain.pl",
	:user_name            => "noreplyvidactica",
	:password             => "vidactica321",
	:authentication       => "plain",
	:enable_starttls_auto => true
}
