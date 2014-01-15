ENV["RACK_ENV"] = "test"

require "./app"
require "rspec"
require "rack/test"

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
