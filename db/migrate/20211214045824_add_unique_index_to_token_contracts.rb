class AddUniqueIndexToTokenContracts < ActiveRecord::Migration[5.2]
  def change
    add_index :token_contracts, :address, unique: true
  end
end
