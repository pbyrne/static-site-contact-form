require "rubygems"
require "sinatra"
require "newrelic_rpm"

require "pony"

require_relative "models/delivery_config"

# Configuration
DELIVERY_CONFIG = DeliveryConfig.new(ENV)
Pony.options = DELIVERY_CONFIG.pony_options

class App < Sinatra::Application
  get "/" do
    "Contact form is up\n"
  end

  post "/" do
    form_contents = params.map do |key, value|
      "#{key}: #{value}"
    end.join("\n")
    puts "Sending:", form_contents
    puts "Referer: #{request.referer}"
    puts "Pony config: #{Pony.options.inspect}"

    Pony.mail(
      to: DELIVERY_CONFIG.recipient,
      subject: "Contact Form Submission",
      body: form_contents,
    )

    redirect DELIVERY_CONFIG.redirect || request.referrer
  end
end
