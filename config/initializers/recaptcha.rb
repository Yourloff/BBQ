Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_BBQ_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_BBQ_PRIVATE_KEY']
end
