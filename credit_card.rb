# frozen_string_literal: true

require_relative './luhn_validator'
require 'json'
require 'base64'
require 'rbnacl'

## CreditCard
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator
  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json(*options)
    {
      # TODO: setup the hash with all instance vairables to serialize into json
      'number' => @number,
      'expiration_date' => @expiration_date,
      'owner' => @owner,
      'credit_network' => @credit_network
    }.to_json(*options)
  end

  # returns all card information as single string
  def to_s
    @number + @expiration_date + @owner + @credit_network
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
    Base64.decode64(card_s)
  end

  # return a hash of the serialized credit card object
  def hash
    # TODO: implement this method
    #   - Produce a hash (using default hash method) of the credit card's
    #     serialized contents.
    #   - Credit cards with identical information should produce the same hash
    Base64.encode64(to_s).hash
  end

  # return a cryptographically secure hash
  def hash_secure
    # TODO: implement this method
    #   - Use sha256 from openssl to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
    RbNaCl::Hash.sha256(Base64.encode64(to_s))
  end
end
