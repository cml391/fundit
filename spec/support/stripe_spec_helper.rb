require 'rspec/mocks'
require 'ostruct'

# we use these sequences to generate fake return values from our mocked
# stripe service
FactoryGirl.define do
  sequence(:stripe_customer_id) {|n| "stripe_customer_#{n}"}
  sequence(:stripe_token_id) {|n| "stripe_customer_#{n}"}
  sequence(:stripe_org_token) {|n| "stripe_org_token_#{n}"}
  sequence(:stripe_pub_key) {|n| "stripe_pub_key_#{n}"}
end

# Stubs Stripe methods so that we don't have to hit the stripe server for
# everything.
def stub_stripe
  suppress_warnings do
    stub_stripe_customer
    stub_stripe_token
    stub_stripe_charge
    stub_stripe_oauth
  end
end

def stub_stripe_oauth
  fake_auth_code= Object.new
  def fake_auth_code.get_token *args
    return OpenStruct.new({
      :token => FactoryGirl.generate(:stripe_org_token),
      :params => {'stripe_publishable_key' => FactoryGirl.generate(:stripe_pub_key)}
    })
  end

  fake_oauth = OpenStruct.new :auth_code => fake_auth_code
  Object.const_set(:STRIPE_OAUTH, fake_oauth)
end

def stub_stripe_customer
  # Stripe::Customer.create
  fake_customer = FakeStripeModule.new do
    FakeStripeCustomer.new(FactoryGirl.generate :stripe_customer_id)
  end

  Stripe.const_set(:Customer, fake_customer)
end

def stub_stripe_token
  # Stripe::Token.create
  fake_token = FakeStripeModule.new do
    FakeStripeToken.new(FactoryGirl.generate :stripe_token_id)
  end

  Stripe.const_set(:Token, fake_token)
end

def stub_stripe_charge
  # Stripe::Charge.create
  fake_charge = FakeStripeModule.new do
    nil
  end

  Stripe.const_set(:Charge, fake_charge)
end

class FakeStripeModule
  def initialize &block
    @block = block
  end

  def create *args
    @block.call
  end
end

FakeStripeCustomer = Struct.new(:id)
FakeStripeToken = Struct.new(:id)