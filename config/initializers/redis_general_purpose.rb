# frozen_string_literal: true

redis_url = ENV.fetch('REDIS_URL') { 'redis://redis' }
redis_db = '0'
REDIS_GENERAL_PURPOSE_URL = "#{redis_url}/#{redis_db}"

Rails.logger.info "General purpose Redis at #{REDIS_GENERAL_PURPOSE_URL}"

$redis = ConnectionPool.new(size: 5, timeout: 10) do
  Redis.new(url: REDIS_GENERAL_PURPOSE_URL)
end

$redis.with(timeout: 15) do |conn|
  conn.client('setname', "Boilerplate-general-PID-#{Process.pid}") unless ENV['SKIP_REDIS'] == '1'
end
