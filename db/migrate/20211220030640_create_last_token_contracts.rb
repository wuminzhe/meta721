class CreateLastTokenContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :last_token_contracts do |t|
      t.string :address

      t.timestamps
    end
  end
end
