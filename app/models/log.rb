class Log < ApplicationRecord
  belongs_to :user
  belongs_to :supervisor
  belongs_to :service
  belongs_to :type
end
