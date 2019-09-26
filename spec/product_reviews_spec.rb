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
  "total": 10,
  "pages": 1,
  "this_page": 1,
  "reviews": [
    {
      "author": "Extremely happy customer :)",
      "title": "So happy!",
      "review": "Great app & great surgeon had my nose done with him 6 months ago and very happy with the results! :)",
      "original_title": "So happy!",
      "original_review": "Great app & great surgeon had my nose done with him 6 months ago and very happy with the results! :)",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2013-09-08T12:31:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LMZFNAEP14DA17opqFW0qkw==",
      "predicted_langs": [
        "en"
      ]
    },
    {
      "author": "Extremely happy customer :)",
      "title": "So happy!",
      "review": "Great app & great surgeon had my nose done with him 6 months ago and very happy with the results! :)",
      "original_title": "So happy!",
      "original_review": "Great app & great surgeon had my nose done with him 6 months ago and very happy with the results! :)",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2013-09-08T12:31:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LIw1AZww6P2h2ot9ZkjylXQ==",
      "predicted_langs": [
        "en"
      ]
    },
    {
      "author": "GelatinousFire",
      "title": "Easy to use, helpful",
      "review": "I think I've been getting carried away with using this app too much. The only thing I would suggest is having a feature to save the before and after together, especially if the photo was taken in-app and not saved on the device already.",
      "original_title": "Easy to use, helpful",
      "original_review": "I think I've been getting carried away with using this app too much. The only thing I would suggest is having a feature to save the before and after together, especially if the photo was taken in-app and not saved on the device already.",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2013-09-07T03:17:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LTWoPGlw4Jv1mL6Is4IfvJA==",
      "predicted_langs": [
        "en"
      ]
    },
    {
      "author": "Needanewnose",
      "title": "Awesome from me too",
      "review": "Excellent idea - very helpful if considering surgery!!",
      "original_title": "Awesome from me too",
      "original_review": "Excellent idea - very helpful if considering surgery!!",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2012-12-31T08:29:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LABQtADfYjihiTLnGfoitww==",
      "predicted_langs": [
        "en"
      ]
    },
    {
      "author": "Aplen",
      "title": "Awesome",
      "review": "Love this app. Works fine.",
      "original_title": "Awesome",
      "original_review": "Love this app. Works fine.",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2012-11-01T11:45:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LWwOvS-+7wc5CYg1fNybp+w==",
      "predicted_langs": [
        "en"
      ]
    },
    {
      "author": "Buybuybuybuy",
      "title": "Awesome",
      "review": "Aww now I really want a nose job!!!",
      "original_title": "Awesome",
      "original_review": "Aww now I really want a nose job!!!",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2012-08-18T04:28:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LbHD103TUYNFH-ef0ZBJl-w==",
      "predicted_langs": [
        "en"
      ]
    },
    {
      "author": "Shnoz66",
      "title": "Fix my nose",
      "review": "Great app Dr Shahidi Love your work",
      "original_title": "Fix my nose",
      "original_review": "Great app Dr Shahidi Love your work",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2012-06-22T22:37:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936Lk31Vr1HbM0zRYqCw6fwxUw==",
      "predicted_langs": [
        "en",
        "af",
        "la",
        "nl"
      ]
    },
    {
      "author": "Shnoz66",
      "title": "Fix my nose",
      "review": "Great app Dr Shahidi<br/>Love your work",
      "original_title": "Fix my nose",
      "original_review": "Great app Dr Shahidi<br/>Love your work",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2012-06-22T10:37:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936Lgo8PsGRm1+ZtKI0wLiagdQ==",
      "predicted_langs": [
        "en",
        "af",
        "la",
        "nl"
      ]
    },
    {
      "author": "Happypatient",
      "title": "Dr Shahidi",
      "review": "The app is fun and Dr Shahidi is a genius!",
      "original_title": "Dr Shahidi",
      "original_review": "The app is fun and Dr Shahidi is a genius!",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2012-02-16T07:30:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LBbqGDq1qPu6LuLMS4tCj7w==",
      "predicted_langs": [
        "la",
        "en",
        "cy",
        "af",
        "lb"
      ]
    },
    {
      "author": "Eddy EF",
      "title": "Facial plastic surgery",
      "review": "It's a great facial surgeries performed by this doctor, I recommend it.",
      "original_title": "Facial plastic surgery",
      "original_review": "It's a great facial surgeries performed by this doctor, I recommend it.",
      "stars": "5.00",
      "iso": "AU",
      "version": null,
      "date": "2011-10-13T07:30:00",
      "product": 6764936,
      "weight": 0,
      "id": "6764936LmBQyYvLr3+vY-hWhn1lt4g==",
      "predicted_langs": [
        "en"
      ]
    }
  ]
}

      EOF
      @api = Appfigures.new username: 'test', password: 'test', client_key: 'test'
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/v2/reviews?lang=en&products=6764936') { [status_code, headers, body] }
      end
      @api.connection.adapter :test, @stubs
  end

  let(:product_id) { "6764936" }

  it 'returns 10 reviews' do
    expect(@api.product_reviews(product_id).reviews.count).to eq(10)
  end


  it 'returns review text' do
    expect(@api.product_reviews(product_id).reviews[0].review).to eq("Great app & great surgeon had my nose done with him 6 months ago and very happy with the results! :)")
  end

  it 'returns review title' do
    expect(@api.product_reviews(product_id).reviews[1].title).to eq("So happy!")
  end

  it 'returns review stars' do
    expect(@api.product_reviews(product_id).reviews[0].stars).to eq("5.00")
  end


end