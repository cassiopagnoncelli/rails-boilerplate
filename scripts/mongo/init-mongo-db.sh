set -e

mongo --host mongo -u boilerplate -p boilerplate <<-EOF
use $MONGO_DBNAME

db.test.insert({ ok: 1 })
EOF
