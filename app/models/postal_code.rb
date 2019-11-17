# == Schema Information
#
# Table name: postal_codes
#
#  id         :integer          not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostalCode < ActiveRecord::Base
  has_many :transporter_postal_codes
  has_many :transporters, through: :transporter_postal_codes
end
