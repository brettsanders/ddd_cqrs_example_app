class AddCreatedByToWalletsReadModel < ActiveRecord::Migration[5.2]
  def change
    add_column :wallets, :created_by, :string
  end
end
