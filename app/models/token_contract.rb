# == Schema Information
#
# Table name: token_contracts
#
#  id         :bigint           not null, primary key
#  address    :string(255)
#  name       :text(65535)
#  symbol     :text(65535)
#  metadata   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TokenContract < ApplicationRecord
end
