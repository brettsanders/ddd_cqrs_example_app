require 'aggregate_root'

module Wallets
  class Wallet
    include AggregateRoot

    AlreadyCreated = Class.new(StandardError)
    InvalidAmount = Class.new(StandardError)

    def initialize(id)
      @id = id
      @amount = 0
      @created_by = nil
    end

    attr_accessor :created_by

    def add_amount(amount)
      @amount += amount
    end

    def create_new_wallet(user = "Brett")
      raise AlreadyCreated unless created_by.nil?
      apply NewWalletCreated.new(data: {wallet_id: @id, amount: @amount, created_by: user})
    end

    def add_money(amount, description)
      raise InvalidWalletNoCreator if created_by.nil?
      raise InvalidAmount if amount < 0

      apply MoneyAddedToWallet.new(
        data: {
          wallet_id: @id,
          amount: amount,
          description: description
        }
      )
    end

    on NewWalletCreated do |event|
      self.created_by = event.data[:created_by]
    end

    on MoneyAddedToWallet do |event|
      self.add_amount(event.data[:amount])
    end

    private

    attr_accessor :amount
  end
end