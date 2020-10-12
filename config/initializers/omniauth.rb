# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "Dgj5yyElQwQhRs2jCsL9YcHA1", "PxzXlFpYRYThSjcdEzjEyOHbBL1yLKcON9MaRNn0NVivwqu8z4"
end