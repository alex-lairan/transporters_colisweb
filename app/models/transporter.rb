# == Schema Information
#
# Table name: transporters
#
#  id         :integer          not null, primary key
#  name       :string
#  siret      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Transporter < ActiveRecord::Base
  has_many :carriers

  has_many :transporter_postal_codes
  has_many :postal_codes, through: :transporter_postal_codes
end
