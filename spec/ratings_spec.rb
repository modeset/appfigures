require 'spec_helper'

describe 'Appfigures country sales' do
  before do
    status_code = 200
    headers = {
      'Cache-Control'       => 'private',
      'Content-Type'        => 'application/json',
      'Server'              => 'Microsoft-IIS/7.5',
      'X-AspNetMvc-Version' => '2.0',
      'X-Request-Limit'     => '1000',
      'X-Request-Usage'     => '4',
      'X-AspNet-Version'    => '4.0.30319',
      'X-Server-ID'         => '10',
      'Date'                => 'Tue, 24 Jul 2012 19:56:51 GMT',
      'Connection'          => 'close',
      'Transfer-Encoding'   => 'Identity'
    }
    body = <<-EOF
[
  {
    "product": 6239092,
    "date": "2015-11-01T00:00:00",
    "stars": [
      16,
      4,
      5,
      8,
      29
    ]
  }
]
      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v2/ratings?group_by=product&products=6239092') { [status_code, headers, body] }
      end
      @api.connection.adapter :test, @stubs
  end

  let(:product_id) { "6239092" }

  it 'returns star breakdown' do
    expect(@api.product_ratings(product_id).stars).to eq([16, 4, 5, 8, 29])
  end

  it 'returns product' do
    expect(@api.product_ratings(product_id).product).to eq(product_id.to_i)
  end




end
