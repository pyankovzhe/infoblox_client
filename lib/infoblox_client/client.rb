module InfobloxClient
  class Client

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

    def performe_get_request(path)
      response = connection.get("#{@host}#{path}")
      JSON.parse(response.body)
    end

  end
end
