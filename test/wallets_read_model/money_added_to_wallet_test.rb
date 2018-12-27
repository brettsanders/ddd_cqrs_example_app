require 'test_helper'

module WalletsReadModel
  class MoneyAddedToWallet < ActiveJob::TestCase
    test 'add money' do
      event_store = Rails.configuration.event_store

      wallet_id = SecureRandom.uuid
      wallet = Wallet.create!(
        uid: wallet_id,
        balance: 0
      )

      event_store.publish(
        Wallets::MoneyAddedToWallet.new(
          data: {wallet_id: wallet_id, amount: 100}
        )
      )

      assert_equal(Wallet.count, 1)
      wallet = Wallet.find_by(uid: wallet_id)
      assert_equal(wallet.balance, 100)
      assert_equal(wallet.uid, wallet_id)

      # Transactions
      wallet_transactions = WalletTransaction.where(wallet_uid: wallet.uid)
      assert_equal(wallet_transactions.length, 1)

      wt = wallet_transactions.first
      assert_equal(wt.wallet_uid, wallet.uid)
      assert_equal(wt.transaction_type, "deposit")
      assert_equal(wt.description, "")
      assert_equal(wt.balance, 100)
    end
  end
end
