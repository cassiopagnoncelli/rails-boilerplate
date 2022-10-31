# MaxMind Geolite file.
# Latest free file available for download at
# https://www.maxmind.com/en/accounts/632621/geoip/downloads
#
$geolite_file = File.join(Rails.root, 'lib', 'assets', 'geolite', 'GeoLite2-City.mmdb')

$maxmind = MaxMindDB.new($geolite_file, MaxMindDB::LOW_MEMORY_FILE_READER)

# MaxMind GeoIP2 (+Insights)
# Gem: 'maxmind-geoip2'
# OS requirement: libmaxminddb
# Use $geoip2.insights('...')
# More info at
#   https://dev.maxmind.com/geoip/geolocate-an-ip/web-services?lang=en
#   https://www.maxmind.com/en/geoip2-precision-insights
# 
# $geoip2 = MaxMind::GeoIP2::Reader.new($geolite_file)

# Geocoder.
Geocoder.configure(
  # Geocoding options
  timeout: 3,                 # geocoding service timeout (secs)
  lookup: :nominatim,         # name of geocoding service (symbol)
  ip_lookup: :geoip2,      # name of IP address geocoding service (symbol), eg. :ipinfo_io, :geoip2, :maxmind_local, :maxmind_geoip2
  language: :en,              # ISO-639 language code
  use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # api_key: nil,               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys
  cache: Redis.new,
  cache_options: {
    prefix: 'geocoder:'
  },

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  units: :km,                 # :km for kilometers or :mi for miles
  distances: :spherical,          # :spherical or :linear

  geoip2: {
    lib: 'maxminddb',
    file: $geolite_file
  }

  # maxmind_local: {
  #   file: $geolite_file
  # }
)

