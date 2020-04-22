# -*- encoding : utf-8 -*-
module Exchanger
  class Config
    include Singleton

    attr_accessor :endpoint, :timeout, :username, :password, :domain, :debug,
                  :insecure_ssl, :acts_as, :version, :auth_type, :ssl_version,
                  :access_token

    def initialize
      reset
    end

    # Reset the configuration options to the defaults.
    def reset
      @endpoint = nil
      @timeout = 5
      @username = nil
      @password = nil
      @debug = false
      @insecure_ssl = false
      @acts_as = nil
      @version = nil
      @auth_type = :basic_auth
      @domain = nil
      @ssl_version = nil
      @access_token = nil
    end

    # Configure Exchanger client from a hash. This is usually called after parsing a
    # yaml config file such as exchanger.yml.
    #
    # Example:
    #
    # <tt>Exchanger::Config.instance.from_hash({})</tt>
    def from_hash(settings)
      settings.each do |name, value|
        send("#{name}=", value) if respond_to?("#{name}=")
      end
    end
  end
end
