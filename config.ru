require 'rack/parser'
require './app'

use Rack::Parser, parsers: {
  'application/json' => proc { |body| JSON.parse(body) },
}

run ApiHandler