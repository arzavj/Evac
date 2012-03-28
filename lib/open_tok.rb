$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

=begin
 OpenTok Ruby Library
 http://www.tokbox.com/

 Copyright 2010, TokBox, Inc.

 Last modified: @opentok.sdk.ruby.mod_time@
=end


require 'rubygems'
require 'net/http'
require 'uri'
require 'digest/md5'
require 'cgi'
#require 'pp' # just for debugging purposes

Net::HTTP.version_1_2 # to make sure version 1.2 is used

module OpenTok
  API_URL = "http://staging.tokbox.com/hl"
  #Uncomment this line when you launch your app
  #API_URL = "https://api.opentok.com/hl";
end

require 'OpenTok/Exceptions'
require 'OpenTok/OpenTokSDK'
