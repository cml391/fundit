= FundIt

== Setup

First, move config/stripe.example.yml to config/stripe.yml and fill in the
secret and publishable keys. Alernatively, you can run the server with the
he environment variables STRIPE_SECRET_KEY and STRIPE_PUB_KEY set to your keys.

Then, Rails standard setup: `bundle install`, `rake db:migrate`, `rails server`



== Demo

A demo is served courtesy of Heroku at http://fundit.herokuapp.com