module WalletsReadModel
  class OnNewWalletCreated
    def call(event)
      Wallet.create!(
        uid: event.data[:wallet_id],
        balance: event.data[:amount],
        created_by: event.data[:created_by]
      )
    end
  end
end
