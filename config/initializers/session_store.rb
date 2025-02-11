# # frozen_string_literal: true
#
# # Use cache_store as session_store for Rails sessions. Key default is 'secure_auth'
#
# Rails.application.config.session_store :cache_store, key: '_secure_auth_v1', expire_after: 24.hours.seconds,
#                                        domain: :all
