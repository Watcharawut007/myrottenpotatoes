# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "hGohyULwIfBINYvUcZMZd1lwC", "ZURlDASAdCLAD6Z9kx9e3L948qpg0IaoeyB3MDa64kmXcbFeR5"
end