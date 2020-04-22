# -*- encoding : utf-8 -*-
module Exchanger
  class Client
    delegate :endpoint, :timeout, :username, :password, :domain, :debug, :insecure_ssl,
             :acts_as, :version, :auth_type, :ssl_version, :access_token to: 'Exchanger.config'

    def endpoint_uri
      @uri ||= URI.parse(endpoint)
    end

    def initialize
      @client = Net::HTTP.new(endpoint_uri.host, endpoint_uri.port)
      @client.set_debug_output STDERR if debug
      @client.use_ssl = true
      @client.ssl_version = ssl_version || :TLSv1
      @client.verify_mode = OpenSSL::SSL::VERIFY_NONE if insecure_ssl
    end

    # Does the actual HTTP level interaction.
    def request(post_body, headers)
      request = Net::HTTP::Post.new(endpoint_uri.path, headers)
      authenticate(request) if username
      request.body = post_body
      response = @client.request(request)
      { status: response.code.to_i, body: response.body, content_type: response.content_type }
    end

    private

    def authenticate(request)
      case auth_type.to_sym
      when :basic_auth then request.basic_auth(username, password)
      when :ntlm_auth then request.ntlm_auth(username, domain, password)
      when :oauth_auth then request.oauth!(@client, self, access_token)
      end
    end
  end
end
