Devise.setup do |config|
  config.mailer_sender = "haslo@haslo.ch"
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = '8f567600e48bc34654d503de58d821308be03e37ec289f0cca2986b5b99b4bce924cc51d6733b3dbc906fecefd6f825d4af0a9d0b6d5711c8b2a411a737051b8'
end
