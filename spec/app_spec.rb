require "spec_helper"

describe App do
  let(:app) { App }

  describe "GET /" do
    it "responds" do
      get "/"
      expect(last_response).to be_ok
      expect(last_response).to match("Test")
    end
  end

  describe "POST /" do
    it "delivers an email to the configured admins"
    it "redirects back to the success page if configured"
    it "responds with a bare thank-you message if not configured"
  end
end
