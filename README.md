# FundIt

## Setup

First, move config/stripe.example.yml to config/stripe.yml and fill in the
secret and publishable keys. Alernatively, you can run the server with the
he environment variables STRIPE_SECRET_KEY and STRIPE_PUB_KEY set to your keys.

Then, Rails standard setup: `bundle install`, `rake db:migrate`, `rails server`

## Demo

A demo is served courtesy of Heroku at http://fundit.herokuapp.com

### Acknowledgements

* [Stripe](https://stripe.com/)
* [Twitter Boostrap](http://twitter.github.com/bootstrap/)
* [Rails](http://rubyonrails.org/)
* [jQuery](http://jquery.com/)
* [twitter-boostrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)
* [Evan Eckard, dinpattern.com](http://www.dinpattern.com/2011/07/27/bit-tile-blue/)
