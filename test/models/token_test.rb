# == Schema Information
#
# Table name: tokens
#
#  id                     :bigint           not null, primary key
#  token_uri              :text(16777215)
#  mint_time              :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  token_contract_id      :integer
#  token_contract_address :string(255)
#  token_id               :string(255)
#
require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
