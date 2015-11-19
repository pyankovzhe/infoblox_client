require "infoblox_client/client/records"
require "infoblox_client/client/zones"

module InfobloxClient
  class Client
    include InfobloxClient::Client::Records
    include InfobloxClient::Client::Zones

    def initialize(attrs)
      @host = "https://#{host}/wapi/v2.1/"
      @username = username
      @password = password
    end

    def connection
      client = HTTPClient.new(base_url: @host, default_header:{  
        'Authorization' => "Basic #{Base64.strict_encode64 "#{@username}:#{@password}"}"
      })    
      client.connect_timeout = 180
      client.send_timeout = 240
      client.receive_timeout = 180
      client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
      client
    end

    def get(path)
      response = connection.get("#{@host}#{path}")
      JSON.parse(response.body)
    end

    def post(path, body)
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      connection.post("#{@host}#{path}", body, headers)
    end

    def delete(path)
      delete_request = -> { connection.delete("#{@host}#{path}") }
      handle_response(&delete_request)
    end

    def dns_member
      get('member:dns').last
    end

    def handle_response(&block)
      response = block.call
      if response.status < 300
        { 'ref' => response.body.gsub(/["]/, '') }
      else
        { 'error_message' => response.body }
      end
    end
  end
end
