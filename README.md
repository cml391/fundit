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

## Test Suite

FundIt includes a test suite that exercises all public controller methods.
It can be run with `rake spec`.

### Acknowledgements

* [Stripe](https://stripe.com/)
* [Twitter Boostrap](http://twitter.github.com/bootstrap/)
* [Rails](http://rubyonrails.org/)
* [RSpec](http://rspec.info/)
* [Factory Girl](https://github.com/thoughtbot/factory_girl)
* [Coffeescript](http://coffeescript.org/)
* [Less CSS](http://lesscss.org/)
* [jQuery](http://jquery.com/)
* [twitter-boostrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)
* [BalusC, Form clear button](http://stackoverflow.com/a/2803922)
* [Brock Kenzler, from The Noun Project](http://thenounproject.com/noun/piggy-bank/#icon-No925)
* [bootstrap-datepicker](http://www.eyecon.ro/bootstrap-datepicker/)

