# Base worker
#
# Read:
# - https://github.com/mperham/sidekiq/wiki/Best-Practices
class SidekiqBase
  include Sidekiq::Job
  include Sidekiq::Benchmark::Worker
  include Sidekiq::Status::Worker
  include Sidekiq::Throttled::Worker

  THROTTLE_OBSERVER = lambda do |strategy, *args|
    # do something
  end

  # https://github.com/mperham/sidekiq/wiki/Job-Lifecycle
  sidekiq_options queue: :low, retry: false

  # https://github.com/sensortower/sidekiq-throttled
  sidekiq_throttle(
    # Add an observer
    # observer: THROTTLE_OBSERVER,

    # Allow maximum 10 concurrent jobs of this class at a time.
    concurrency: { limit: 10 },

    # Allow maximum 1K jobs being processed within one hour window.
    threshold: { limit: 1_000, period: 1.hour }
  )

  def perform(**args)
    raise NotImplementedError
  end

  # Expiration in Sidekiq::Status listing
  # https://github.com/kenaniah/sidekiq-status
  def expiration
    @expiration ||= 60 * 60 * 24 * 3 # 3 days
  end

  def serialized
    { job_class: self.class.to_s, provider_job_id: self.jid }.stringify_keys.to_json
  end
end
