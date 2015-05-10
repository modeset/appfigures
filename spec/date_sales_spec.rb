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
            "product": {
              "id": 123123,
              "ref_no": "536354432",
              "external_account_id": 397,
              "store_id": 0,
              "store_name": "apple",
              "added_timestamp": "2012-07-23T00:00:00",
              "name": "Test App",
              "icon": "http://a5.mzstatic.com/us/r1000/091/Purple/v4/20/69/65/20696562-4e19-17fe-5ffe-cb77a78e1651/mzl.jtpselsb.png",
              "active": true,
              "hidden": false,
              "sku": "TEST_APP",
              "in_apps": [],
              "product_type": "app",
              "addons": []
            }
          }
        }
      }
      EOF
    body223123 = <<-EOF
      {
	"2012-09-01": {
	  "223123": {
	    "downloads": 30,
	    "product": {
	      "id": 223123
	    }
	  }
	}
      }
      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
	    stub.get('/v2/sales/dates+products/2012-09-01/2012-09-01?products=223123') { [status_code, headers, body223123] }
      stub.get('/v2/sales/dates+products/2012-09-01/2012-09-01') { [status_code, headers, body] }
	end
      @api.connection.adapter :test, @stubs
  end

  let(:start_date) { Date.parse('2012-09-01') }
  let(:end_date) { Date.parse('2012-09-01') }

  it 'returns a product ID' do
    expect(@api.date_sales(start_date, end_date).first.product_id).to eq(123123)
  end

  it 'returns a store ID' do
    expect(@api.date_sales(start_date, end_date).first.store_id).to eq(0)
  end
  it 'returns a store name' do
    expect(@api.date_sales(start_date, end_date).first.store_name).to eq('apple')
  end
  it 'returns a name' do
    expect(@api.date_sales(start_date, end_date).first.name).to eq('Test App')
  end
  it 'returns a sku' do
    expect(@api.date_sales(start_date, end_date).first.sku).to eq('TEST_APP')
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
