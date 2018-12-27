module WalletsReadModel
  class WalletTransaction < ApplicationRecord
    self.table_name = "wallet_transactions"

    enum transaction_type: { deposit: 0, withdrawal: 1 }

  end
end