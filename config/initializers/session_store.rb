# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_minesweeper_session',
  :secret      => '4a4032cb17fe417e5d2ecd4574e9bb669206143443a90f8c79b3cde990ab07ca94e8e09b4c325c5cbaabca4e7103501ad9bc373158feb6c57588892f55d18bd0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
