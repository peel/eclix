require 'coveralls'
Coveralls.wear!
require 'pry'
require 'eclix'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
