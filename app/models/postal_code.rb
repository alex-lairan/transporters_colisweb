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
end
