require 'test_helper'

# Question: Does a Create command make sense?
# Seems to me is useful to know WHO created it (say for company based system)
# As well as WHEN created
# Seems will make Sense when I do Logged In

module Wallets
  class CreateNewWalletTest < ActiveSupport::TestCase
    include TestCase

    cover 'Wallets::OnCreateNewWallet*'

    test 'create new wallet' do
      aggregate_id = SecureRandom.uuid
      stream = "Wallets::Wallet$#{aggregate_id}"

      published = act(
        stream,
        CreateNewWallet.new(
          wallet_id: aggregate_id,
        )
      )

      assert_changes(
        published,
        [
          NewWalletCreated.new(
            data: {
              wallet_id: aggregate_id,
              amount: 0,
              created_by: "Brett"
            }
          )
        ]
      )
    end

  end
end