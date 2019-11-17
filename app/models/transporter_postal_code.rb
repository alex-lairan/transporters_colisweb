# == Schema Information
#
# Table name: transporter_postal_codes
#
#  id             :integer          not null, primary key
#  transporter_id :integer
#  postal_code_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TransporterPostalCode < ActiveRecord::Base
  belongs_to :transporter
  belongs_to :postal_code
end
