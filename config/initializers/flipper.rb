redis_url = ENV.fetch('REDIS_URL') { 'redis://redis:6379' }
redis_db = '2'
redis_endpoint = "#{redis_url}/#{redis_db}"

conn = Redis.new(url: redis_endpoint)

Flipper.configure do |config|
  config.adapter { Flipper::Adapters::Redis.new(conn) }
end
