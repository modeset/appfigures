require 'spec_helper'

describe 'Appfigures product reviews' do
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
        "au": {
          "store_id": 143460,
          "country": "Australia",
          "iso_country": "AU",
          "all_ratings": 0,
          "ratings": 0,
          "all_stars": "0.00",
          "stars": "0.00",
          "num_pages": null,
          "num_reviews": null,
          "all_star_breakdown": "",
          "star_breakdown": "",
          "reviews": []
        },
        "ca": {
          "store_id": 143455,
          "country": "Canada",
          "iso_country": "CA",
          "all_ratings": 0,
          "ratings": 0,
          "all_stars": "0.00",
          "stars": "0.00",
          "num_pages": 1,
          "num_reviews": null,
          "all_star_breakdown": "",
          "star_breakdown": "",
          "reviews": [
            {
              "title": "Future of apps",
              "review": "Work data at my fingertips. Less need to be at the office.",
              "original_title": "Future of app",
              "original_review": "Work data at my fingertips. Less need to be at the office.",
              "author": "reviewer123",
              "version": "2.2.0",
              "date": "31-Aug-2012",
              "stars": "5.00",
              "review_type": "review",
              "type": "major",
              "id": 143455,
              "iso": "CA",
              "country": "Canada"
            }
          ]
        },
        "de": {
          "store_id": 143443,
          "country": "Germany",
          "iso_country": "DE",
          "all_ratings": 0,
          "ratings": 0,
          "all_stars": "0.00",
          "stars": "0.00",
          "num_pages": null,
          "num_reviews": null,
          "all_star_breakdown": "",
          "star_breakdown": "",
          "reviews": []
        },
        "us": {
            "store_id": 143441,
            "country": "United States",
            "iso_country": "US",
            "all_ratings": 0,
            "ratings": 0,
            "all_stars": "0.00",
            "stars": "0.00",
            "num_pages": 1,
            "num_reviews": null,
            "all_star_breakdown": "",
            "star_breakdown": "",
            "reviews": [
            {
              "title": "Great app!",
              "review": "Fantastic way to communicate.",
              "original_title": "Great app!",
              "original_review": "Fantastic way to communicate.",
              "author": "OneTimeHiker",
              "version": "2.0.0",
              "date": "21-Jun-2012",
              "stars": "5.00",
              "review_type": "review",
              "type": "major",
              "id": 143441,
              "iso": "US",
              "country": "United States"
            },
            {
              "title": "office manager",
              "review": "Lorem ipsum",
              "original_title": "office manager",
              "original_review": "Lorem ipsum",
              "author": "Lilly, office manager",
              "version": "1.0.7",
              "date": "10-Apr-2012",
              "stars": "5.00",
              "review_type": "review",
              "type": "major",
              "id": 143441,
              "iso": "US",
              "country": "United States"
            }
            ]
        }
      }
      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v2/reviews/1234567/major/0') { [status_code, headers, body] }
      end
      @api.connection.adapter :test, @stubs
  end

  let(:product_id) { "1234567" }
  let(:countries) { "major" }

  it 'returns 4 countries' do
    expect(@api.product_reviews(product_id, countries).count).to eq(4)
  end

  it 'au returns 0 reviews' do
    expect(@api.product_reviews(product_id, countries).first.reviews.count).to eq(0)
  end

  it 'ca returns review text' do
    expect(@api.product_reviews(product_id, countries)[1].reviews[0].review).to eq("Work data at my fingertips. Less need to be at the office.")
  end


end
