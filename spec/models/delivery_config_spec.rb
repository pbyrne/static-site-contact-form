require "spec_helper"
require_relative "../../models/delivery_config"

describe DeliveryConfig do

  let(:smtp_options) {{
    "DELIVERY_SERVER" => "smtp://username:password@example.com:1234",
  }}
  let(:sendgrid_options) {{
    "SENDGRID_USERNAME" => "app123@heroku.com",
    "SENDGRID_PASSWORD" => "password",
  }}

  describe "#pony_options" do

    it "parses information from DELIVERY_SERVER" do
      subject = DeliveryConfig.new(smtp_options)
      expect(subject.pony_options).to eq(
        via: :smtp,
        via_options: {
          address: "example.com",
          port: 1234,
          domain: "heroku.com",
          user_name: "username",
          password: "password",
          authentication: :plain,
          enable_starttls_auto: true,
        },
      )
    end

    it "parses information from SENDGRID_*" do
      subject = DeliveryConfig.new(sendgrid_options)
      expect(subject.pony_options).to eq(
        via: :smtp,
        via_options: {
          address: "smtp.sendgrid.net",
          domain: "heroku.com",
          port: 587,
          user_name: sendgrid_options["SENDGRID_USERNAME"],
          password: sendgrid_options["SENDGRID_PASSWORD"],
          authentication: :plain,
          enable_starttls_auto: true,
        },
      )
    end

    it "fails if given no delivery configuration information" do
      expect { DeliveryConfig.new.pony_options }.to raise_error(DeliveryConfig::ConfigurationError)
    end

  end

  describe "#recipient" do

    subject { DeliveryConfig.new("RECIPIENT" => recipient) }

    let(:recipient) { "foo@example.com" }

    it "parses from RECIPIENT" do
      expect(subject.recipient).to eq(recipient)
    end

  end

  describe "#redirect" do

    let(:redirect) { "http://example.com" }

    it "parses from REDIRECT" do
      subject = DeliveryConfig.new("REDIRECT" => redirect)
      expect(subject.redirect).to eq(redirect)
    end

    it "is nil if unconfigured" do
      subject = DeliveryConfig.new
      expect(subject.redirect).to be_nil
    end

  end
end
