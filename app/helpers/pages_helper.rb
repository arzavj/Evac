require 'rubygems'
require 'openssl'
require 'base64'
require 'yajl'

module PagesHelper
  class SignedRequest
    def initialize
    end

  def call(params)
    if params.is_a?(Hash)
      signed_request = params.delete('signed_request')
    else
      signed_request  = params
    end

    unless signed_request
      return Rack::Response.new(["Missing signed_request param"], 400).finish
    end

    signature, signed_params = signed_request.split('.')
    signed_params = Yajl::Parser.new.parse(base64_url_decode(signed_params))

    return signed_params
  end

  private

    def signed_request_is_valid?(secret, signature, params)
      signature = base64_url_decode(signature)
      expected_signature = OpenSSL::HMAC.digest('SHA256', secret, params.tr("-_", "+/"))
      return signature == expected_signature
    end

    def base64_url_decode(str)
      str = str + "=" * (6 - str.size % 6) unless str.size % 6 == 0
      return Base64.decode64(str.tr("-_", "+/"))
    end
  end
end

facebook = FacebookRegistration::SignedRequest.new
#parsed_params = facebook.call(params["signed_request"])
#puts parsed_params.inspect
