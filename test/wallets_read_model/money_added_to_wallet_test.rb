require 'test_helper'

module WalletsReadModel
  class MoneyAddedToWallet < ActiveJob::TestCase
    test 'add money' do
      event_store = Rails.configuration.event_store

      wallet_id = SecureRandom.uuid

      event_store.publish(
        Wallets::MoneyAddedToWallet.new(
          data: {wallet_id: wallet_id, amount: 100}
        )
      )

      assert_equal(Wallet.count, 1)
      wallet = Wallet.find_by(uid: wallet_id)
      assert_equal(wallet.balance, 100)
      assert_equal(wallet.uid, wallet_id)
    end
  end
end
