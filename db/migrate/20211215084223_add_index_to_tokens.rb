class AddIndexToTokens < ActiveRecord::Migration[5.2]
  def change
    add_index :tokens, [:token_contract_address, :token_id]
  end
end
