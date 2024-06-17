require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false

  config.eager_load = true

  config.consider_all_requests_local = false

  config.active_storage.service = :local

  config.force_ssl = true

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: 'smtp-relay.sendinblue.com',
    port: 587,
    domain: 'neobazaar-ee1c625c2e80.herokuapp.com',
    user_name: ENV['SENDINBLUE_SMTP_USERNAME'],
    password: ENV['SENDINBLUE_SMTP_PASSWORD'],
    authentication: 'login',
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = { host: 'neobazaar-ee1c625c2e80.herokuapp.com', protocol: 'https' }

  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  config.log_tags = [ :request_id ]

  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")


  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.report_deprecations = false

  config.active_record.dump_schema_after_migration = false

end
