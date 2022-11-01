redis_url = ENV.fetch('REDIS_URL') { 'redis://redis' }
redis_db = '2'
redis_ns = 'session'

Boilerplate::Application.config.session_store :redis_store,
  servers: ["#{redis_url}/#{redis_db}/#{redis_ns}"],
  expire_after: 90.minutes,
  key: "_boilerplate_session",
  threadsafe: true,
  secure: true
