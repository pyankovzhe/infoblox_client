require 'spec_helper'

describe InfobloxClient::Client do

  let(:client) { InfobloxClient::Client.new('10.10.10.1', 'fake admin', 'wrong password') }

  it 'returns error for wrong credentials' do
    expect { client.create_zone({'fqdn' => 'text.com'}) }.to raise_error(HTTPClient::ConnectTimeoutError)
  end
end
