require 'test_helper'

# Question: What is the point of require_relative in the test_helper
# When the files are loaded in the config/application.rb ???
# It doesn't seem to do anything

module Wallets
  class AddMoneyToWalletTest < ActiveSupport::TestCase
    include TestCase

    cover 'Wallets::OnAddMoneyToWallet*'

    def setup
      @aggregate_id = SecureRandom.uuid
      @stream = "Wallets::Wallet$#{@aggregate_id}"
      # Must create Wallet first
      act(@stream, CreateNewWallet.new(wallet_id: @aggregate_id))
    end

    test 'money deposited' do
      # 'act' adds the event then diffs before/after of event @stream
      # returns just the 'published' events

      amount = 100
      description = "Funding from Mr VC Man"
      published = act(
        @stream,
        AddMoneyToWallet.new(
          wallet_id: @aggregate_id,
          amount: amount,
          description: description
        )
      )

      assert_changes(
        published,
        [
          MoneyAddedToWallet.new(
            data: {wallet_id: @aggregate_id, amount: amount}
          )
        ]
      )
    end

    test 'negative amount raises error' do
      amount = -100

      assert_raises(Wallet::InvalidAmount) do
        act(
          @stream,
          AddMoneyToWallet.new(
            wallet_id: @aggregate_id,
            amount: amount
          )
        )
      end
    end
  end

end