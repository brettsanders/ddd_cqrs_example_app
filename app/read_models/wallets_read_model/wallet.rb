module WalletsReadModel
  class Wallet < ApplicationRecord
    self.table_name = "wallets"
  end
end