module WalletsReadModel
  class OnMoneyAddedToWallet
    def call(event)
      wallet = Wallet.find_by(uid: uid)
      return unless wallet
      
      wallet = find_or_create_wallet_read_model_by_uid(event.data[:wallet_id])
      wallet.balance += event.data[:amount]
      wallet.save!
    end
  end
end
