require 'appfigures/version'
require 'appfigures/connection'
require 'utils/hash_extensions'

require 'date'

class Appfigures
  attr_reader :connection
  def initialize(options = {})
    @connection = Appfigures::Connection.new options[:username], options[:password], options[:client_key]
  end

  #https://api.appfigures.com/v2/reports/sales/?group_by=product&client_key=c0725e4c875b412fbca6b12b5db44a4e
  def product_sales
    url = 'reports/sales'
    options = {group_by: 'product'}

    self.connection.get(url, options).body.map do |id, hash|
      Hashie::Mash.new({
        'product_id'      => hash['product']['id'],
        'store_id'        => hash['product']['store_id'],
        'store_name'      => hash['product']['store'],
        'name'            => hash['product']['name'],
        'sku'             => hash['product']['sku'],
        'ref_no'          => hash['product']['ref_no'],
        'added_timestamp' => Date.parse(hash['product']['source']['added_timestamp']),
        'icon'            => hash['product']['icon'],
        'downloads'       => hash['downloads'].to_i,
        'returns'         => hash['returns'].to_i,
        'updates'         => hash['updates'].to_i,
        'net_downloads'   => hash['net_downloads'].to_i,
        'promos'          => hash['promos'].to_i,
        'gift_redemptions'=> hash['gift_redemptions'].to_i,
        'revenue'         => hash['revenue'].to_f,
        'active'          => hash['product']['source']['active']
      })
    end
  end


  # GET /reports/sales/dates+products?start=2013-03-01&end=2013-03-31
  # See http://docs.appfigures.com/api/reference/v2/sales
  def date_sales(start_date, end_date, options = {})
    url = "reports/sales/dates+products"

    options = {start: start_date.strftime('%Y-%m-%d'),
               end: end_date.strftime('%Y-%m-%d')}.merge(options)

    self.connection.get(url, options).body.map do |date, product|
      product.map do |product_id, hash|
        Hashie::Mash.new({
          'date'            => Date.parse(date),
          'product_id'      => hash['product_id'].to_i,
          'downloads'       => hash['downloads'].to_i,
          'returns'         => hash['returns'].to_i,
          'updates'         => hash['updates'].to_i,
          'net_downloads'   => hash['net_downloads'].to_i,
          'promos'          => hash['promos'].to_i,
          'gift_redemptions'=> hash['gift_redemptions'].to_i,
          'revenue'         => hash['revenue'].to_f
        })
      end.first
    end
  end

  # GET /reports/sales?group_by=country&start=start_date&end=end_date
  # See http://docs.appfigures.com/api/reference/v2/sales
  def country_sales(start_date, end_date, options = {})
    url = "reports/sales"
    options = {group_by: 'country',
               start: start_date.strftime('%Y-%m-%d'),
               end: end_date.strftime('%Y-%m-%d')}.merge(options)
    #"/?group_by=country&start=#{start_date.strftime('%Y-%m-%d')}/#{end_date.strftime('%Y-%m-%d')}#{options.to_query_string(true)}"
    self.connection.get(url, options).body.map do |country, hash|
      Hashie::Mash.new({
          'iso'             => hash['iso'],
          'country'         => hash['country'],
          'downloads'       => hash['downloads'],
          'updates'         => hash['updates'],
          'returns'         => hash['returns'],
          'net_downloads'   => hash['net_downloads'],
          'promos'          => hash['promos'],
          'revenue'         => hash['revenue'],
          'gift_redemptions' => hash['gift_redemptions'],
      })
    end
  end

  # GET /reviews?products={productId}&lang=en
  # See http://docs.appfigures.com/api/reference/v2/reviews
  def product_reviews(product_id, options = {})
    url = "reviews"
    options = {products: product_id,
               lang: 'en'
              }.merge(options)
    response = self.connection.get(url, options).body
    reviews = Hashie::Mash.new({
                             'total' => response['total'].to_i,
                             'pages' => response['pages'].to_i,
                             'this_page' => response['this_page'].to_i,
                             'reviews' => response['reviews'].map do |review|
                               Hashie::Mash.new({
                                                    'author'  => review['author'],
                                                    'title'   => review['title'],
                                                    'review'  => review['review'],
                                                    'stars'   => review['stars'],
                                                    'iso'     => review['iso'],
                                                    'version' => review['version'],
                                                    'date'    => review['date'],
                                                    'product' => review['product'],
                                                    'id'      => review['id']
                                                })
                             end
              })
  end

  # GET /ratings?group_by=product&products={productId}
  def product_ratings(product_id, options = {})
    url = "ratings"
    options = {group_by: 'product',
               products: product_id}.merge(options)
    self.connection.get(url, options).body.map do |product, hash|
      Hashie::Mash.new({
          'breakdown' => hash['breakdown'],
          'average' => hash['average'],
          'product_id' => hash['product_id']
      })
    end.first
  end

end
