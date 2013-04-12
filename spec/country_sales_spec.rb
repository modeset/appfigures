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
	"US": {
	  "downloads": 213,
	  "updates": 715,
	  "returns": 0,
	  "net_downloads": 213,
	  "promos": 0,
	  "revenue": "0.00",
	  "gift_redemptions": 0,
	  "country": "United States",
	  "iso": "US"
	},
	"VE": {
	  "downloads": 1,
	  "updates": 2,
	  "returns": 0,
	  "net_downloads": 1,
	  "promos": 0,
	  "revenue": "0.00",
	  "gift_redemptions": 0,
	  "country": "Venezuela",
	  "iso": "VE"
	}
      }
      EOF
      @api = Appfigures.new username: 'test', password: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v1.1/sales/countries/2013-03-01/2013-03-31') { [status_code, headers, body] }
      end
      @api.connection.adapter :test, @stubs
  end

  let(:start_date) { Date.parse('2013-03-01') }
  let(:end_date) { Date.parse('2013-03-31') }

  it 'returns an iso' do
    expect(@api.country_sales(start_date, end_date).first.iso).to eq("US")
  end

  it 'returns downloads' do
    expect(@api.country_sales(start_date, end_date).first.downloads).to eq(213)
  end


end
