require 'appfigures/version'
require 'appfigures/connection'

class Appfigures
  attr_reader :connection
  def initialize(options = {})
    @connection = Appfigures::Connection.new options[:username], options[:password]
  end

  def product_sales
    self.connection.get('sales/products').body.map do |id, hash|
      Hashie::Mash.new({
        'product_id'      => hash['product']['id'],
        'store_id'        => hash['product']['store_id'],
        'store_name'      => hash['product']['store_name'],
        'name'            => hash['product']['name'],
        'sku'             => hash['product']['sku'],
        'downloads'       => hash['downloads'].to_i,
        'returns'         => hash['returns'].to_i,
        'updates'         => hash['updates'].to_i,
        'net_downloads'   => hash['net_downloads'].to_i,
        'promos'          => hash['promos'].to_i,
        'gift_redemptions'=> hash['gift_redemptions'].to_i,
        'revenue'         => hash['revenue'].to_f
      })
    end
  end
end
