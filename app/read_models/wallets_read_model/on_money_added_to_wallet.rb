module WalletsReadModel
  class OnMoneyAddedToWallet
    def call(event)
      wallet = find_or_create_wallet_read_model_by_uid(event.data[:wallet_id])
      wallet.balance += event.data[:amount]
      wallet.save!
    end

    private
    # Todo: Require the Wallet to be created by explicit Event CreateWallet
    def find_or_create_wallet_read_model_by_uid(uid)
      wallet = Wallet.find_by(uid: uid)

      if wallet
        wallet
      else
        Wallet.create!(
          uid: uid,
          balance: 0,
        )
      end
    end

  end
end
