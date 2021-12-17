# == Schema Information
#
# Table name: token_contracts
#
#  id          :bigint           not null, primary key
#  address     :string(255)
#  name        :text(65535)
#  symbol      :text(65535)
#  metadata    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  blacklisted :boolean
#
require 'test_helper'

class TokenContractTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
