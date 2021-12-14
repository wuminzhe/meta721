class AddTokenContractIdAndTokenIdToTokens < ActiveRecord::Migration[5.2]
  def change
    add_column :tokens, :token_contract_id, :integer
    add_column :tokens, :token_contract_address, :string
    add_column :tokens, :token_id, :string
    remove_column :tokens, :full_id
  end
end
