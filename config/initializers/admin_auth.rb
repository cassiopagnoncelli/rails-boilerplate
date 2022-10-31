# https://github.com/mperham/sidekiq/wiki/Monitoring
# https://www.flippercloud.io/docs/ui
class AdminAuth
  def self.admin?(request)
    authenticate :user, ->(user) { user.admin? } do
      return true
    end
    false
  end
end
