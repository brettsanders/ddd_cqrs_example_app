module Wallets
  class OnAddMoneyToWallet
    include CommandHandler

    def call(command)
      with_aggregate(Wallet, command.aggregate_id) do |wallet|
        wallet.add_money(command.amount, command.description)
      end
    end
  end
end