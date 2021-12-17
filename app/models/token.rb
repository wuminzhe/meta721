# == Schema Information
#
# Table name: tokens
#
#  id                     :bigint           not null, primary key
#  token_uri              :text(65535)
#  owner_address          :string(255)
#  mint_time              :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  token_contract_id      :integer
#  token_contract_address :string(255)
#  token_id               :string(255)
#  metadata               :text(65535)
#
class Token < ApplicationRecord
  belongs_to :token_contract, optional: true
end
