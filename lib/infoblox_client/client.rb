require "infoblox_client/client/records"
require "infoblox_client/client/zones"

module InfobloxClient
  class Client
    include InfobloxClient::Client::Records
    include InfobloxClient::Client::Zones

    def initialize(host, username, password)
      @host = "https://#{host}/wapi/v2.1/"
      @username = username
      @password = password
    end

    def connection
      client = HTTPClient.new
      client.set_auth(@host, @username, @password)
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

    private

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
