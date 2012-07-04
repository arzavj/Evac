# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{facebook_registration}
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Veerasundaravel Thirugnanasundaram"]
  s.date = %q{2011-12-26}
  s.description = %q{facebook_registration is a ruby library for displaying new Facebook Registration form and to parse to signed_request[http://developers.facebook.com/docs/plugins/registration].}
  s.email = ["veerasundaravel@gmail.com"]
  s.files = ["test/test_fb_registration.rb", "test/test_fb_registration_helper.rb"]
  s.homepage = %q{http://veerasundaravel.wordpress.com/2011/01/27/facebook-registration-plugin-in-rails/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{facebook_registration}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{facebook_registration is a ruby library for displaying new Facebook Registration form and to parse to signed_request[http://developers.facebook.com/docs/plugins/registration]. by Veerasundaravel Thirugnanasundaram}
  s.test_files = ["test/test_fb_registration.rb", "test/test_fb_registration_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yajl-ruby>, [">= 0.7.6"])
    else
      s.add_dependency(%q<yajl-ruby>, [">= 0.7.6"])
    end
  else
    s.add_dependency(%q<yajl-ruby>, [">= 0.7.6"])
  end
end
