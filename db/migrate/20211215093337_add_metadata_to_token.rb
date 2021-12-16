class AddMetadataToToken < ActiveRecord::Migration[5.2]
  def change
    add_column :tokens, :metadata, :text
  end
end
