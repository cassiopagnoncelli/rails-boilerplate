set -e

cd engines/stern

bundle install

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
