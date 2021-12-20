class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :full_id
      t.text :token_uri, limit: 16.megabytes - 1
      t.string :owner_address
      t.datetime :mint_time

      t.timestamps
    end
  end
end
