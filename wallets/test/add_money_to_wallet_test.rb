require 'test_helper'

# Question: What is the point of require_relative in the test_helper
# When the files are loaded in the config/application.rb ???
# It doesn't seem to do anything

module Wallets
  class AddMoneyToWalletTest < ActiveSupport::TestCase
    include TestCase

    cover 'Wallets::OnAddMoneyToWallet*'

    test 'money is added to wallet' do
      aggregate_id = SecureRandom.uuid
      stream = "Wallets::Wallet$#{aggregate_id}"

      # value object - where put?
      # first, do just plain amount then try to add currency
      # Money = Struct.new(:amount, :curency)
      # money = Money.new(100, 'USD')

      amount = 100

      # 'act' adds the event then diffs before/after of event stream
      # returns just the 'published' events
      published = act(
        stream,
        AddMoneyToWallet.new(
          wallet_id: aggregate_id,
          amount: amount
        )
      )

      assert_changes(
        published,
        [
          MoneyAddedToWallet.new(
            data: {wallet_id: aggregate_id, amount: amount}
          )
        ]
      )
    end

    test 'amount added must be positive value' do
      aggregate_id = SecureRandom.uuid
      stream = "Wallets::Wallet$#{aggregate_id}"

      amount = -100

      assert_raises(Wallet::InvalidAmount) do
        act(
          stream,
          AddMoneyToWallet.new(
            wallet_id: aggregate_id,
            amount: amount
          )
        )
      end
    end
  end

end