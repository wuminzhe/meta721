class ChangeMintTimeTypeOfTokens < ActiveRecord::Migration[5.2]
  def up
    change_column :tokens, :mint_time, :integer
  end

  def down
    change_column :tokens, :mint_time, :datetime
  end
end
