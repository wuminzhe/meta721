class CreateTokenContractsInfos < ActiveRecord::Migration[5.2]
  def up
    create_table :token_contracts_infos do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :token_contracts_infos, :key, unique: true

    TokenContractsInfo.create(key: "last_token_contract_address", value: nil)
    TokenContractsInfo.create(key: "token_contracts_count", value: "0")
    TokenContractsInfo.create(key: "ctrl", value: "0") # 1: stop
  end
  
  def down
    drop_table :token_contracts_infos
  end
end
