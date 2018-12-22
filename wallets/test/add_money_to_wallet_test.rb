require 'test_helper'

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

      # Act adds the event then diffs before/after of event stream
      # returns just the 'published' events
      published = act(
        stream,
        AddMoneyToWallet.new(wallet_id: aggregate_id, amount: amount)
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
  end
end