require 'rubocop'
require 'sinatra'
require 'redis'
require 'uri'

configure do
  REDISTOGO_URL = "redis://localhost:6379/"
  uri = URI.parse(REDISTOGO_URL)
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/set' do
  key = params['key']
  value = params['value']
  if key and value
    REDIS.set(key, value.to_s)
    "204"
  end
end

get '/get' do
  key = params['key']
  if key
    return REDIS.get(key)
  end
end
