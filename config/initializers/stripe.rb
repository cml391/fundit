if File.exists? 'config/stripe.yml'
  yml = IO.read(File.expand_path('../../stripe.yml', __FILE__))
  STRIPE_KEYS = YAML.load(yml)
else
  STRIPE_KEYS = {
    'secret_key' => ENV['STRIPE_SECRET_KEY'],
    'pub_key'    => ENV['STRIPE_PUB_KEY'],
    'client_id'  => ENV['STRIPE_CLIENT_ID']
  }
end

Stripe.api_key = STRIPE_KEYS['secret_key']

STRIPE_OAUTH = OAuth2::Client.new(STRIPE_KEYS['client_id'], '', {
  :site => 'https://connect.stripe.com',
  :authorize_url => '/oauth/authorize',
  :token_url => '/oauth/token'
})