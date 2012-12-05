# FundIt

## Setup

First, move config/stripe.example.yml to config/stripe.yml and fill in the
secret and publishable keys. Alernatively, you can run the server with the
he environment variables STRIPE_SECRET_KEY and STRIPE_PUB_KEY set to your keys
and STRIPE_CLIENT_ID set to your Stripe Connect app's client ID.

Second, move config/filepicker.example.yml to config/filepicker.yml and
fill in the API key. Alternatively, you can run the server with the
environment variable FILEPICKER_KEY set to your API key.

Then, do the Rails standard setup: `bundle install`, `rake db:migrate`,
`rails server`

## Demo

A demo is served courtesy of Heroku at http://fundit.herokuapp.com

### Acknowledgements

* [Stripe](https://stripe.com/)
* [Twitter Boostrap](http://twitter.github.com/bootstrap/)
* [Rails](http://rubyonrails.org/)
* [jQuery](http://jquery.com/)
* [twitter-boostrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)
* [BalusC, Form clear button](http://stackoverflow.com/a/2803922)
