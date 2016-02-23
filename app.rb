require "rubygems"
require "sinatra"

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

    Pony.mail(
      to: DELIVERY_CONFIG.recipient,
      from: DELIVERY_CONFIG.sender,
      reply_to: params[:email],
      subject: "Contact Form Submission",
      body: form_contents,
    )

    redirect DELIVERY_CONFIG.redirect || request.referrer
  end
end
