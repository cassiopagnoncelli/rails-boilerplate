class HeartbeatJob < SidekiqBase
  def perform(*_args)
    total 2

    at 1, "Updating timestamp"

    $redis.with do |conn| # rubocop:disable Style/GlobalVars
      conn.set('health_check', Time.now.to_i.to_s)
    end

    Rails.logger.info serialized

    at 2, "Finished"
  end
end
