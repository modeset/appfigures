require 'appfigures/version'
require 'appfigures/connection'
require 'utils/hash_extensions'

require 'date'

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
        'ref_no'          => hash['product']['ref_no'],
        'added_timestamp' => Date.parse(hash['product']['added_timestamp']),
        'icon'            => hash['product']['icon'],
        'downloads'       => hash['downloads'].to_i,
        'returns'         => hash['returns'].to_i,
        'updates'         => hash['updates'].to_i,
        'net_downloads'   => hash['net_downloads'].to_i,
        'promos'          => hash['promos'].to_i,
        'gift_redemptions'=> hash['gift_redemptions'].to_i,
        'revenue'         => hash['revenue'].to_f,
        'active'          => hash['product']['active']
      })
    end
  end


  # GET /sales/dates+products/2013-03-01/2013-03-31
  # See http://docs.appfigures.com/api/reference/v1-1/sales
  def date_sales(start_date, end_date, options = {})
    url = "sales/dates+products/#{start_date.strftime('%Y-%m-%d')}/#{end_date.strftime('%Y-%m-%d')}#{options.to_query_string(true)}"
    self.connection.get(url).body.map do |date, product|
      product.map do |product_id, hash|
        Hashie::Mash.new({
          'date'            => Date.parse(date),
          'product_id'      => hash['product']['id'],
          'store_id'        => hash['product']['store_id'],
          'store_name'      => hash['product']['store_name'],
          'name'            => hash['product']['name'],
          'sku'             => hash['product']['sku'],
          'ref_no'          => hash['product']['ref_no'],
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

  # GET /sales/country/{start_date}/{end_date}?data_source={data_source}&products={product_ids}&country={country}&format={format}
  # See http://docs.appfigures.com/api/reference/v1-1/sales
  def country_sales(start_date, end_date, options = {})
    url = "sales/countries/#{start_date.strftime('%Y-%m-%d')}/#{end_date.strftime('%Y-%m-%d')}#{options.to_query_string(true)}"
    self.connection.get(url).body.map do |country, hash|
      Hashie::Mash.new({
          'iso'             => hash['iso'],
          'country'         => hash['country'],
          'downloads'       => hash['downloads'],
          'updates'         => hash['updates'],
          'returns'         => hash['returns'],
          'net_downloads'   => hash['net_downloads'],
          'promos'          => hash['promos'],
          'revenue'         => hash['revenue'],
          'git_redemptions' => hash['gift_redemptions'],
      })
    end
  end

  # GET /reviews/{productId}/{countries}/{page}/?language={language}
  # See http://docs.appfigures.com/api/reference/v1-1/reviews
  def product_reviews(product_id, countries, page = 0, options = {})
    url = "reviews/#{product_id}/#{countries}/#{page}#{options.to_query_string(true)}"
    country_reviews = self.connection.get(url).body.map do |country, hash|
        Hashie::Mash.new({
          'num_reviews'         => hash['num_reviews'],
          'all_ratings'         => hash['all_ratings'],
          'ratings'             => hash['ratings'],
          'all_stars'           => hash['all_stars'],
          'stars'               => hash['stars'],
          'all_star_breakdown'  => hash['all_star_breakdown'],
          'star_breakdown'      => hash['star_breakdown'],
          'iso'                 => hash['iso_country'],
          'country'             => hash['country'],
          'reviews'             => hash['reviews'].map do |review|
            Hashie::Mash.new({
             'stars'   => review['stars'],
             'date'    => review['date'],
             'title'   => review['title'],
             'review'  => review['review'],
             'version' => review['version'],
             'author'  => review['author']
            })
          end
        })
      end
  end





end
