# == Schema Information
#
# Table name: carriers
#
#  id                   :integer          not null, primary key
#  name                 :string
#  age                  :integer
#  has_driver_licence_a :boolean
#  has_driver_licence_b :boolean
#  has_driver_licence_c :boolean
#  transporter_id       :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Carrier < ActiveRecord::Base
  belongs_to :transporter
end
