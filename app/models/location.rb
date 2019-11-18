# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  altitude   :float
#  carrier_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  belongs_to :carrier
end
