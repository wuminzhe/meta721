class ChangeNameAndSymbolTypeOfTokenContracts < ActiveRecord::Migration[5.2]
  def up
    change_column :token_contracts, :name, :text
    change_column :token_contracts, :symbol, :text
  end

  def down
    change_column :token_contracts, :name, :string
    change_column :token_contracts, :symbol, :string
  end
end
