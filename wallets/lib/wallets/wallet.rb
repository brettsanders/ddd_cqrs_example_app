require 'aggregate_root'

module Wallets
  class Wallet
    include AggregateRoot

    InvalidAmount = Class.new(StandardError)

    def initialize(id)
      @id = id
      @amount = 0
    end

    def add_amount(amount)
      @amount += amount
    end

    def add_money(amount)
      raise InvalidAmount if amount < 0
      apply MoneyAddedToWallet.new(data: {wallet_id: @id, amount: amount})
    end

    on MoneyAddedToWallet do |event|
      self.add_amount(event.data[:amount])
    end

    private

    attr_accessor :amount
  end
end