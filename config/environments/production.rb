RedFeed::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true # Make it true for heroku

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Cache static assets for atleast 1 year
  config.static_cache_control = "max-age=31536000, private"

  # Don't fallback to assets pipeline if a precompiled asset is missed
  # Ritvij Comment - Ideally this is false but had to do it because active_admin does not work on
  # Heroku without this being true. also check the extra setting done at config.assets.precompile
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = false

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :log

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  BASE_URL = "http://reader.pykih.com"
  STATIC_WEBSITE = "http://reader.pykih.com"
  REDIRECTING_URL = "http://reader.pykih.com"
  
  GOOGLE_KEY = ENV['GOOGLE_KEY']
  GOOGLE_SECRET = ENV['GOOGLE_SECRET']
  
  config.action_mailer.default_url_options = { :host => 'jarvis-bi.com' }
  config.middleware.use ExceptionNotifier,
    exception_recipients: 'support@pykih.freshdesk.com',
    sender_address: %{jarvisbi@pykih.com},
    sections: ExceptionNotifier::Notifier.default_sections,
    ignore_crawlers: %w{Googlebot bingbot},
    email_format: true,
    normalize_subject: true#, TODO - fix
    #sections: %w{current_user} + ExceptionNotifier::Notifier.default_sections,
  
  #ActionMailer::Base.delivery_method = :smtp
  #ActionMailer::Base.smtp_settings = {
    #:address              => "smtp.gmail.com",
    #:port                 => "587",
    #:domain               => "www.gmail.com",
    #:user_name            => "theviri01@gmail.com",
    #:password             => "thepykih12345",
    #:authentication       => "plain",
    #:enable_starttls_auto => true,
    #:openssl_verify_mode  => 'none'
  #}
  
  config.action_mailer.delivery_method   = :postmark
  config.action_mailer.postmark_settings = { :api_key => "bc1a3da3-1526-4d48-a3cf-2ed2872013d1" }

end