require "rubygems"
require "sinatra"

class App < Sinatra::Application
  get "/" do
    "Test page!"
  end
end
