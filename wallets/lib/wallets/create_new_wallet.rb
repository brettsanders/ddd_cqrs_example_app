module Wallets
  class CreateNewWallet < Command
    attribute :wallet_id, Types::UUID

    alias :aggregate_id :wallet_id
  end
end