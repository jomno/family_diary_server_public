Rails.application.config.session_store :cookie_store, key: "access_token", same_site: :none, secure: :true, domain: :all
