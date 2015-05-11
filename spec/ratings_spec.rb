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
{
  "5556625": {
    "breakdown": [
      874,
      276,
      460,
      690,
      2300
    ],
    "observed": false,
    "average": "3.71",
    "product": {
      "id": 5556625,
      "name": "Plastic Surgery w/ Dr. Miller",
      "developer": "Pixineers Inc",
      "icon": "https://lh6.ggpht.com/jrfahsvasiddXZkGi3HOl8nBRpk8ADqSmje_FFHZG5b-YMOC1aqX1WJSUMoPuY98jY3J",
      "vendor_identifier": "com.pixineers.philipmiller",
      "ref_no": null,
      "sku": "com.pixineers.philipmiller",
      "package_name": "com.pixineers.philipmiller",
      "store_id": 2,
      "store": "google_play",
      "storefront": "google_play",
      "release_date": "2011-12-02T19:21:57",
      "added_date": "2011-12-02T19:21:57",
      "updated_date": "2015-05-11T09:08:22",
      "version": " 1.9.4  ",
      "source": null,
      "type": "app",
      "devices": [
        "Handheld"
      ],
      "bundle_identifier": "com.pixineers.philipmiller"
    },
    "product_id": 5556625
  }
}
      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v2/ratings?group_by=product&products=5556625') { [status_code, headers, body] }
      end
      @api.connection.adapter :test, @stubs
  end

  let(:product_id) { "5556625" }

  it 'returns star breakdown' do
    expect(@api.product_ratings(product_id).breakdown).to eq([874, 276, 460, 690, 2300])
  end

  it 'returns average' do
    expect(@api.product_ratings(product_id).average).to eq("3.71")
  end




end
