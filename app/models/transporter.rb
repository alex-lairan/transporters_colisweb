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
end
