module WalletsReadModel
  class OnMoneyAddedToWallet
    def call(event)
      wallet = Wallet.find_by(uid: event.data[:wallet_id])
      return unless wallet

      wallet.balance += event.data[:amount]
      wallet.save!
    end
  end
end
