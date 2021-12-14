class CreateTokenContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :token_contracts do |t|
      t.string :address
      t.string :name
      t.string :symbol
      t.boolean :metadata

      t.timestamps
    end
  end
end
