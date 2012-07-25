require 'rubygems'
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'appfigures'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
