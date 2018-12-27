module WalletsReadModel
  class OnMoneyAddedToWallet
    def call(event)
      wallet = Wallet.find_by(uid: event.data[:wallet_id])
      return unless wallet

      wallet.balance += event.data[:amount]
      wallet.save!

      # Given need access to the balance, seems to make sense
      # that the Wallet Transaction Read Model should be coupled
      # to the Wallet Read Model
      WalletTransaction.create!(
        wallet_uid: wallet.uid,
        transaction_type: :deposit,
        description: event.data[:description],
        amount_deposited: event.data[:amount],
        balance: wallet.balance
      )
    end
  end
end
