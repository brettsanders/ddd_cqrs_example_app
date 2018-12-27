class CreateWalletTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :wallet_transactions do |t|
      t.string :wallet_uid
      t.column :transaction_type, :integer, default: 0
      t.string :description
      t.integer :amount_deposited
      t.integer :amount_withdrawn
      t.integer :balance

      t.timestamps null: false
    end
  end
end