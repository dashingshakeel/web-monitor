class Service < ApplicationRecord
  has_one :type
  belongs_to :supervisor
end
