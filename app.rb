require 'rubocop'
require 'sinatra'
require 'redis'
require 'thin'
require 'uri'

configure do
  REDISTOGO_URL = "redis://localhost:6379/"
  uri = URI.parse(REDISTOGO_URL)
  REDIS = Redis.new(:host => uri.host, :port => uri.port)
end

get '/set' do
  key = params['key']
  value = params['value']
  if key and value
    REDIS.set(key, value.to_s)
    Thin::HTTP_STATUS_CODES[204] = "No Content"
  else
    Thin::HTTP_STATUS_CODES[404] = "Not Found"
  end
end

get '/get' do
  key = params['key']
  if key and params['key']!=""
    return REDIS.get(key)
  else
    Thin::HTTP_STATUS_CODES[404] = "Not Found"
  end
end
