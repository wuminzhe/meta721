class DropLastTokenControls < ActiveRecord::Migration[5.2]
  def change
    drop_table :last_token_contracts
  end
end
