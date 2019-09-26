require 'appfigures/version'
require 'appfigures/connection'
require 'utils/hash_extensions'

require 'date'
require 'json'

class Appfigures
  attr_reader :connection
  def initialize(options = {})
    @connection = Appfigures::Connection.new options[:username], options[:password], options[:client_key]
  end

  #https://api.appfigures.com/v2/reports/sales/?group_by=product&client_key=c0725e4c875b412fbca6b12b5db44a4e
  def product_sales
    url = 'reports/sales'
    options = {group_by: 'product'}

    response = self.connection.get(url, options)
    response.body.map do |id, hash|
      if response.status == 200 
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
      else
        puts 'Appfigures service error:'
        puts hash.to_json
        Hashie::Mash.new
      end
    end
  end


  # GET /reports/sales/dates+products?start=2017-03-01&end=2017-03-31&products=6403600
  # See http://docs.appfigures.com/api/reference/v2/sales
  def date_sales(start_date, end_date, options = {})
    url = "reports/sales/dates+products"

    options = {start: start_date.strftime('%Y-%m-%d'),
               end: end_date.strftime('%Y-%m-%d')}.merge(options)

    response = self.connection.get(url, options)
    if response.status == 200 
      response.body.map do |date, product|
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
    else
      response.body.map do |id, hash|
        puts 'Appfigures service error:'
        puts hash.to_json
        Hashie::Mash.new
      end
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
    
    response = self.connection.get(url, options)
    response.body.map do |country, hash|
      if response.status == 200 
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
      else
        puts 'Appfigures service error:'
        puts hash.to_json
        Hashie::Mash.new
      end
    end
  end

  # GET /reviews?products={productId}&lang=en
  # See http://docs.appfigures.com/api/reference/v2/reviews
  def product_reviews(product_id, options = {})
    url = "reviews"
    options = {products: product_id,
               lang: 'en'
              }.merge(options)

    response = self.connection.get(url, options)
    if response.status == 200
      body = response.body
      reviews = Hashie::Mash.new({
                               'total' => body['total'].to_i,
                               'pages' => body['pages'].to_i,
                               'this_page' => body['this_page'].to_i,
                               'reviews' => body['reviews'].map do |review|
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
    else
      puts 'Appfigures service error:'
      puts response.body.to_json
      return Hashie::Mash.new
    end
  end

  # GET /ratings?group_by=product&start_date={today}&end_date={today}products={productId}
  def product_ratings(product_id, options = {})
    url = "ratings"
    now = Time.now
    today = Date.new(now.year, now.month, now.day).strftime('%Y-%m-%d')

    options = {group_by: 'product',
               products: product_id,
               start_date: today,
               end_date: today}.merge(options)

    response = self.connection.get(url, options)
    response.body.map do |product, hash|
      if response.status == 200
        Hashie::Mash.new({
            'stars' => product['stars'],
            'product' => product['product']
        })
      else
        puts 'Appfigures service error:'
        puts hash.to_json
        return Hashie::Mash.new
      end
    end.first
  end

end
