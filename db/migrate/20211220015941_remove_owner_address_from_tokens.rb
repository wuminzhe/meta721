class RemoveOwnerAddressFromTokens < ActiveRecord::Migration[5.2]
  def change
    remove_column :tokens, :owner_address
  end
end
