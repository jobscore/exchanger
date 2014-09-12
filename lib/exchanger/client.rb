# -*- encoding : utf-8 -*-
module Exchanger
  class Client
    delegate :endpoint, :timeout, :username, :password, :debug, :insecure_ssl, :acts_as, :version, to: 'Exchanger.config'

    def endpoint_uri
      @uri ||= URI.parse(endpoint)
    end

    def initialize
      @client = Net::HTTP.new(endpoint_uri.host, endpoint_uri.port)
      @client.set_debug_output STDERR if debug
      @client.use_ssl = true
      @client.verify_mode = OpenSSL::SSL::VERIFY_NONE if insecure_ssl
    end

    # Does the actual HTTP level interaction.
    def request(post_body, headers)
      request = Net::HTTP::Post.new(endpoint_uri.path, headers)
      # request.ntlm_auth username, nil, password if username
      request.basic_auth username, password if username
      request.body = post_body
      response = @client.request(request)
      { status: response.code.to_i, body: response.body, content_type: response.content_type }
    end
  end
end
