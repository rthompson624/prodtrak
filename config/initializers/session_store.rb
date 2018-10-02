# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_prodtrak_session',
  :secret      => '410f45fcc390d68ccd6a3ce0270d41386476c45b4220619ec4c9b81aca6f88494909f5adc283d68873bcddb4ecee94957be87b4c9ff8fc201fe6fdbc8fba6aaa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
