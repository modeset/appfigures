require 'spec_helper'

describe 'Appfigures product sales' do
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
        "123123": {
          "downloads": 29,
          "updates": 50,
          "returns": 3,
          "net_downloads": 26,
          "promos": 1,
          "revenue": "100.99",
          "edu_downloads": 0,
          "gifts": 0,
          "gift_redemptions": 10,
          "product": {
            "id": 123123,
            "name": "Test App",
            "developer": "Test Inc",
            "icon": "http://a5.mzstatic.com/us/r1000/091/Purple/v4/20/69/65/20696562-4e19-17fe-5ffe-cb77a78e1651/mzl.jtpselsb.png",
            "vendor_identifier": "23292092",
            "ref_no": "536354432",
            "sku": "TEST_APP",
            "package_name": null,
            "store_id": 0,
            "store": "apple",
            "storefront": "apple:ios",
            "release_date": "2010-12-14T05:00:00",
            "added_date": "2011-11-30T13:02:38",
            "updated_date": "2015-05-06T09:00:53",
            "version": "3.8.0",
            "source": {
              "external_account_id": 397,
              "added_timestamp": "2012-07-23T00:00:00",
              "active": true,
              "hidden": false,
              "type": "own"
            },
            "type": "app",
            "devices": [
              "Handheld",
              "Tablet"
            ],
            "bundle_identifier": "com.appfigures.test",
            "accessible_features": [
              "sales",
              "reviews",
              "reviews_count",
              "ranks",
              "featured"
            ],
            "children": [],
            "features": [],
            "parent_id": null,
            "storefronts": [
              "apple:ios"
            ]
          },
          "product_id": 6403600
        }
      }
      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v2/reports/sales?group_by=product') { [status_code, headers, body] }
      end
      @api.connection.adapter :test, @stubs
  end

  it 'returns a product ID' do
    expect(@api.product_sales.first.product_id).to eq(123123)
  end

  it 'returns a store ID' do
    expect(@api.product_sales.first.store_id).to eq(0)
  end
  it 'returns a store name' do
    expect(@api.product_sales.first.store_name).to eq('apple')
  end
  it 'returns a name' do
    expect(@api.product_sales.first.name).to eq('Test App')
  end
  it 'returns a sku' do
    expect(@api.product_sales.first.sku).to eq('TEST_APP')
  end
  it 'returns a download count' do
    expect(@api.product_sales.first.downloads).to eq(29)
  end
  it 'returns a return count' do
    expect(@api.product_sales.first.returns).to eq(3)
  end
  it 'returns an update count' do
    expect(@api.product_sales.first.updates).to eq(50)
  end
  it 'returns a net download count' do
    expect(@api.product_sales.first.net_downloads).to eq(26)
  end
  it 'returns a promo count' do
    expect(@api.product_sales.first.promos).to eq(1)
  end
  it 'returns a gift redemption count' do
    expect(@api.product_sales.first.gift_redemptions).to eq(10)
  end
  it 'returns a revenue number' do
    expect(@api.product_sales.first.revenue).to eq(100.99)
  end
  it 'returns a ref_no' do
    expect(@api.product_sales.first.ref_no).to eq('536354432')
  end
  it 'returns an added timestamp' do
    expect(@api.product_sales.first.added_timestamp).to eq(Date.parse('2012-07-23T00:00:00'))
  end
  it 'returns an icon' do
    expect(@api.product_sales.first.icon).to eq('http://a5.mzstatic.com/us/r1000/091/Purple/v4/20/69/65/20696562-4e19-17fe-5ffe-cb77a78e1651/mzl.jtpselsb.png')
  end
  it 'returns active' do
    expect(@api.product_sales.first.active).to eq(true)
  end

end
