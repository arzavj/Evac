# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{yajl-ruby}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Lopez", "Lloyd Hilaiel"]
  s.date = %q{2011-11-09}
  s.email = %q{seniorlopez@gmail.com}
  s.extensions = ["ext/yajl/extconf.rb"]
  s.files = ["examples/encoding/chunked_encoding.rb", "examples/encoding/one_shot.rb", "examples/encoding/to_an_io.rb", "examples/http/twitter_search_api.rb", "examples/http/twitter_stream_api.rb", "examples/parsing/from_file.rb", "examples/parsing/from_stdin.rb", "examples/parsing/from_string.rb", "spec/encoding/encoding_spec.rb", "spec/global/global_spec.rb", "spec/http/fixtures/http.bzip2.dump", "spec/http/fixtures/http.chunked.dump", "spec/http/fixtures/http.deflate.dump", "spec/http/fixtures/http.error.dump", "spec/http/fixtures/http.gzip.dump", "spec/http/fixtures/http.html.dump", "spec/http/fixtures/http.raw.dump", "spec/http/http_delete_spec.rb", "spec/http/http_error_spec.rb", "spec/http/http_get_spec.rb", "spec/http/http_post_spec.rb", "spec/http/http_put_spec.rb", "spec/http/http_stream_options_spec.rb", "spec/json_gem_compatibility/compatibility_spec.rb", "spec/parsing/active_support_spec.rb", "spec/parsing/chunked_spec.rb", "spec/parsing/fixtures/fail.15.json", "spec/parsing/fixtures/fail.16.json", "spec/parsing/fixtures/fail.17.json", "spec/parsing/fixtures/fail.26.json", "spec/parsing/fixtures/fail11.json", "spec/parsing/fixtures/fail12.json", "spec/parsing/fixtures/fail13.json", "spec/parsing/fixtures/fail14.json", "spec/parsing/fixtures/fail19.json", "spec/parsing/fixtures/fail20.json", "spec/parsing/fixtures/fail21.json", "spec/parsing/fixtures/fail22.json", "spec/parsing/fixtures/fail23.json", "spec/parsing/fixtures/fail24.json", "spec/parsing/fixtures/fail25.json", "spec/parsing/fixtures/fail27.json", "spec/parsing/fixtures/fail28.json", "spec/parsing/fixtures/fail3.json", "spec/parsing/fixtures/fail4.json", "spec/parsing/fixtures/fail5.json", "spec/parsing/fixtures/fail6.json", "spec/parsing/fixtures/fail9.json", "spec/parsing/fixtures/pass.array.json", "spec/parsing/fixtures/pass.codepoints_from_unicode_org.json", "spec/parsing/fixtures/pass.contacts.json", "spec/parsing/fixtures/pass.db100.xml.json", "spec/parsing/fixtures/pass.db1000.xml.json", "spec/parsing/fixtures/pass.dc_simple_with_comments.json", "spec/parsing/fixtures/pass.deep_arrays.json", "spec/parsing/fixtures/pass.difficult_json_c_test_case.json", "spec/parsing/fixtures/pass.difficult_json_c_test_case_with_comments.json", "spec/parsing/fixtures/pass.doubles.json", "spec/parsing/fixtures/pass.empty_array.json", "spec/parsing/fixtures/pass.empty_string.json", "spec/parsing/fixtures/pass.escaped_bulgarian.json", "spec/parsing/fixtures/pass.escaped_foobar.json", "spec/parsing/fixtures/pass.item.json", "spec/parsing/fixtures/pass.json-org-sample1.json", "spec/parsing/fixtures/pass.json-org-sample2.json", "spec/parsing/fixtures/pass.json-org-sample3.json", "spec/parsing/fixtures/pass.json-org-sample4-nows.json", "spec/parsing/fixtures/pass.json-org-sample4.json", "spec/parsing/fixtures/pass.json-org-sample5.json", "spec/parsing/fixtures/pass.map-spain.xml.json", "spec/parsing/fixtures/pass.ns-invoice100.xml.json", "spec/parsing/fixtures/pass.ns-soap.xml.json", "spec/parsing/fixtures/pass.numbers-fp-4k.json", "spec/parsing/fixtures/pass.numbers-fp-64k.json", "spec/parsing/fixtures/pass.numbers-int-4k.json", "spec/parsing/fixtures/pass.numbers-int-64k.json", "spec/parsing/fixtures/pass.twitter-search.json", "spec/parsing/fixtures/pass.twitter-search2.json", "spec/parsing/fixtures/pass.unicode.json", "spec/parsing/fixtures/pass.yelp.json", "spec/parsing/fixtures/pass1.json", "spec/parsing/fixtures/pass2.json", "spec/parsing/fixtures/pass3.json", "spec/parsing/fixtures_spec.rb", "spec/parsing/one_off_spec.rb", "spec/rcov.opts", "spec/spec_helper.rb", "ext/yajl/extconf.rb"]
  s.homepage = %q{http://github.com/brianmario/yajl-ruby}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby C bindings to the excellent Yajl JSON stream-based parser library.}
  s.test_files = ["examples/encoding/chunked_encoding.rb", "examples/encoding/one_shot.rb", "examples/encoding/to_an_io.rb", "examples/http/twitter_search_api.rb", "examples/http/twitter_stream_api.rb", "examples/parsing/from_file.rb", "examples/parsing/from_stdin.rb", "examples/parsing/from_string.rb", "spec/encoding/encoding_spec.rb", "spec/global/global_spec.rb", "spec/http/fixtures/http.bzip2.dump", "spec/http/fixtures/http.chunked.dump", "spec/http/fixtures/http.deflate.dump", "spec/http/fixtures/http.error.dump", "spec/http/fixtures/http.gzip.dump", "spec/http/fixtures/http.html.dump", "spec/http/fixtures/http.raw.dump", "spec/http/http_delete_spec.rb", "spec/http/http_error_spec.rb", "spec/http/http_get_spec.rb", "spec/http/http_post_spec.rb", "spec/http/http_put_spec.rb", "spec/http/http_stream_options_spec.rb", "spec/json_gem_compatibility/compatibility_spec.rb", "spec/parsing/active_support_spec.rb", "spec/parsing/chunked_spec.rb", "spec/parsing/fixtures/fail.15.json", "spec/parsing/fixtures/fail.16.json", "spec/parsing/fixtures/fail.17.json", "spec/parsing/fixtures/fail.26.json", "spec/parsing/fixtures/fail11.json", "spec/parsing/fixtures/fail12.json", "spec/parsing/fixtures/fail13.json", "spec/parsing/fixtures/fail14.json", "spec/parsing/fixtures/fail19.json", "spec/parsing/fixtures/fail20.json", "spec/parsing/fixtures/fail21.json", "spec/parsing/fixtures/fail22.json", "spec/parsing/fixtures/fail23.json", "spec/parsing/fixtures/fail24.json", "spec/parsing/fixtures/fail25.json", "spec/parsing/fixtures/fail27.json", "spec/parsing/fixtures/fail28.json", "spec/parsing/fixtures/fail3.json", "spec/parsing/fixtures/fail4.json", "spec/parsing/fixtures/fail5.json", "spec/parsing/fixtures/fail6.json", "spec/parsing/fixtures/fail9.json", "spec/parsing/fixtures/pass.array.json", "spec/parsing/fixtures/pass.codepoints_from_unicode_org.json", "spec/parsing/fixtures/pass.contacts.json", "spec/parsing/fixtures/pass.db100.xml.json", "spec/parsing/fixtures/pass.db1000.xml.json", "spec/parsing/fixtures/pass.dc_simple_with_comments.json", "spec/parsing/fixtures/pass.deep_arrays.json", "spec/parsing/fixtures/pass.difficult_json_c_test_case.json", "spec/parsing/fixtures/pass.difficult_json_c_test_case_with_comments.json", "spec/parsing/fixtures/pass.doubles.json", "spec/parsing/fixtures/pass.empty_array.json", "spec/parsing/fixtures/pass.empty_string.json", "spec/parsing/fixtures/pass.escaped_bulgarian.json", "spec/parsing/fixtures/pass.escaped_foobar.json", "spec/parsing/fixtures/pass.item.json", "spec/parsing/fixtures/pass.json-org-sample1.json", "spec/parsing/fixtures/pass.json-org-sample2.json", "spec/parsing/fixtures/pass.json-org-sample3.json", "spec/parsing/fixtures/pass.json-org-sample4-nows.json", "spec/parsing/fixtures/pass.json-org-sample4.json", "spec/parsing/fixtures/pass.json-org-sample5.json", "spec/parsing/fixtures/pass.map-spain.xml.json", "spec/parsing/fixtures/pass.ns-invoice100.xml.json", "spec/parsing/fixtures/pass.ns-soap.xml.json", "spec/parsing/fixtures/pass.numbers-fp-4k.json", "spec/parsing/fixtures/pass.numbers-fp-64k.json", "spec/parsing/fixtures/pass.numbers-int-4k.json", "spec/parsing/fixtures/pass.numbers-int-64k.json", "spec/parsing/fixtures/pass.twitter-search.json", "spec/parsing/fixtures/pass.twitter-search2.json", "spec/parsing/fixtures/pass.unicode.json", "spec/parsing/fixtures/pass.yelp.json", "spec/parsing/fixtures/pass1.json", "spec/parsing/fixtures/pass2.json", "spec/parsing/fixtures/pass3.json", "spec/parsing/fixtures_spec.rb", "spec/parsing/one_off_spec.rb", "spec/rcov.opts", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, [">= 0.7.5"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>, [">= 0.7.5"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, [">= 0.7.5"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
