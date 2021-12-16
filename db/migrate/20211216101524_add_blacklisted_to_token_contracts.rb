class AddBlacklistedToTokenContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :token_contracts, :blacklisted, :boolean
  end
end
