# Appfigures


TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'appfigures'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install appfigures

## Usage

    # Create a new instance passing in your credentials
    api = Appfigures.new username: 'my_username', password: 'my_password'

    # Retrieve product sales
    api.product_sales

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
