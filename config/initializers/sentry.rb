# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = "https://21161c98cf2ddfd87ec24b847d1ef85a@o4509962826547200.ingest.de.sentry.io/4511604255227984"
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]
  config.enabled_environments = [ "production" ]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end
