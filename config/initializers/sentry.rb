# frozen_string_literal: true

Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger]
  config.dsn = ENV.fetch('SENTRY_DSN', nil)

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true

  # Enable sending logs to Sentry
  config.enable_logs = true
  # Patch Ruby logger to forward logs
  config.enabled_patches = [:logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for tracing.
  config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
  #   true
  # end

  # Set profiles_sample_rate to profile 100%
  # of sampled transactions.
  config.profiles_sample_rate = 1.0
end
