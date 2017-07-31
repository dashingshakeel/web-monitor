class Service < ApplicationRecord
  belongs_to :type
  validates :type_id,presence: true
  validates :duration,presence: true
  validates :start_time,presence: true
  validates :end_time,presence: true
  belongs_to :supervisor
end
