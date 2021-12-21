# == Schema Information
#
# Table name: last_token_contracts
#
#  id         :bigint           not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LastTokenContract < ApplicationRecord
end
