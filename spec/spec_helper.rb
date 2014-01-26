ENV["RACK_ENV"] = "test"

require "rspec"
require "rack/test"

RSpec.configure do |config|
  # def with_env_vars(vars)
  #   original = ENV.to_hash
  #   vars.each { |k, v| ENV[k] = v }
  #   begin
  #     yield
  #   ensure
  #     ENV.replace(original)
  #   end
  # end
  config.include Rack::Test::Methods
end
