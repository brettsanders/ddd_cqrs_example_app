module Wallets
  class OnCreateNewWallet
    include CommandHandler

    def call(command)
      with_aggregate(Wallet, command.aggregate_id) do |wallet|
        wallet.create_new_wallet
      end
    end
  end
end