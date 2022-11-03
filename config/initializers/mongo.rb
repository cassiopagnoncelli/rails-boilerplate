# Mongo::Logger.logger.level = Logger::WARN

# mongo_options = {
#   app_name: 'Boilerplate',
#   write_concern: { w: 1 },
#   min_pool_size: 2,
#   max_pool_size: 5,
#   wait_queue_timeout: 10,
#   connect_timeout: 10
# }

# # https://stackoverflow.com/questions/38088279/communication-between-multiple-docker-compose-projects
# # Connect to db authenticating it through admin db.
# #
# # Same docker compose file:
# # mongodb://boilerplate:boilerplate@host.docker.internal:27017/sherlock?authSource=admin
# #
# # Same network:
# # mongodb://boilerplate:boilerplate@mongo/boilerplate?authSource=admin

# $mongo_url = Mongo::Client.new(ENV['MONGO_URL'], mongo_options)
