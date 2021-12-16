class AddIndexToTokens2 < ActiveRecord::Migration[5.2]
  def change
    add_index :tokens, :token_contract_id
  end
end
