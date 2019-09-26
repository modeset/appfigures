require 'spec_helper'

describe 'Appfigures date sales' do
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
        "2012-09-01": {
          "123123": {
            "downloads": 29,
            "updates": 50,
            "returns": 3,
            "net_downloads": 26,
            "promos": 1,
            "revenue": "100.99",
            "gift_redemptions": 10,
            "date": "2012-09-01",
            "product_id": 123123
          }
        }
      }
      EOF
    body223123 = <<-EOF
      {
	"2012-09-01": {
	  "223123": {
	    "downloads": 30,
      "product_id": 223123
	  }
	}
      }
      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|

	    stub.get('/v2/reports/sales/dates+products?end=2012-09-30&products=223123&start=2012-09-01') { [status_code, headers, body223123] }
      stub.get('/v2/reports/sales/dates+products?end=2012-09-30&start=2012-09-01') { [status_code, headers, body] }
	end
      @api.connection.adapter :test, @stubs
  end

  let(:start_date) { Date.parse('2012-09-01') }
  let(:end_date) { Date.parse('2012-09-30') }

  it 'returns a product ID' do
    expect(@api.date_sales(start_date, end_date).first.product_id).to eq(123123)
  end
  it 'returns a download count' do
    expect(@api.date_sales(start_date, end_date).first.downloads).to eq(29)
  end
  it 'returns a return count' do
    expect(@api.date_sales(start_date, end_date).first.returns).to eq(3)
  end
  it 'returns an update count' do
    expect(@api.date_sales(start_date, end_date).first.updates).to eq(50)
  end
  it 'returns a net download count' do
    expect(@api.date_sales(start_date, end_date).first.net_downloads).to eq(26)
  end
  it 'returns a promo count' do
    expect(@api.date_sales(start_date, end_date).first.promos).to eq(1)
  end
  it 'returns a gift redemption count' do
    expect(@api.date_sales(start_date, end_date).first.gift_redemptions).to eq(10)
  end
  it 'returns a revenue number' do
    expect(@api.date_sales(start_date, end_date).first.revenue).to eq(100.99)
  end
  it 'returns a specific product ID' do
    expect(@api.date_sales(start_date, end_date, { :products => 223123 }).first.product_id).to eq(223123)
  end

end
