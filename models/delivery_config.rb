require "uri"

class DeliveryConfig
  SENDGRID_HOST = "smtp.sendgrid.net"
  SMTP_PORT = 587
  # Environment keys used for configuration
  SMTP_KEY = "DELIVERY_SERVER"
  SENDGRID_KEY = "SENDGRID_USERNAME"
  RECIPIENT_KEY = "RECIPIENT"
  REDIRECT_KEY = "REDIRECT"

  def initialize(env={})
    @env = env.to_hash
  end

  def pony_options
    if @env.key?(SMTP_KEY)
      smtp_delivery_options
    elsif @env.key?(SENDGRID_KEY)
      sendgrid_delivery_options
    else
      raise ConfigurationError, "No delivery method configured"
    end
  end

  def recipient
    @env.fetch(RECIPIENT_KEY)
  end

  def redirect
    @env.fetch(REDIRECT_KEY, nil)
  end

  private

  def smtp_delivery_options
    uri = URI.parse(@env.fetch("DELIVERY_SERVER"))
    {
      via: :smtp,
      via_options: {
        address: uri.host,
        port: uri.port || SMTP_PORT,
        domain: "heroku.com",
        user_name: uri.user,
        password: uri.password,
        authentication: :plain,
        enable_starttls_auto: true,
      },
    }
  end

  def sendgrid_delivery_options
    {
      via: :smtp,
      via_options: {
        address: SENDGRID_HOST,
        port: SMTP_PORT,
        domain: "heroku.com",
        user_name: @env.fetch("SENDGRID_USERNAME"),
        password: @env.fetch("SENDGRID_PASSWORD"),
        authentication: :plain,
        enable_starttls_auto: true,
      },
    }
  end

  ConfigurationError = Class.new(StandardError)
end
