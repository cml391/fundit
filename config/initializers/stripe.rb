if File.exists? 'config/stripe.yml'
  yml = IO.read(File.expand_path('../../stripe.yml', __FILE__))
  STRIPE_KEYS = YAML.load(yml)
else
  STRIPE_KEYS = {
    'secret_key' => ENV['STRIPE_SECRET_KEY'],
    'pub_key'    => ENV['STRIPE_PUB_KEY']
  }
end

Stripe.api_key = STRIPE_KEYS['secret_key']