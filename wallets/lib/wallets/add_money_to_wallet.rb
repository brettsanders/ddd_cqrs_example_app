module Wallets
  class AddMoneyToWallet < Command
    attribute :wallet_id, Types::UUID
    attribute :amount, Types::Coercible::Integer

    alias :aggregate_id :wallet_id
  end
end