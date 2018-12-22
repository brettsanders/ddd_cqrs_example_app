class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.string :uid
      t.string :owner_uid
      t.integer :balance
    end
  end
end