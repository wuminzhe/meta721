class AddUniqueIndexToTokens < ActiveRecord::Migration[5.2]
  def change
    add_index :tokens, :full_id, unique: true
  end
end
