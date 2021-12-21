class RemoveTokenContractIdFromTokens < ActiveRecord::Migration[5.2]
  def change
    remove_column :tokens, :token_contract_id
  end
end
