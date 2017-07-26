class Supervisor < ApplicationRecord
  belongs_to :user
   validates :name,presence: true, length: {maximum: 50}
    validates :url,presence: true, length: {maximum: 100}
    has_many :services

  accepts_nested_attributes_for :services,
    :allow_destroy => true,
    :reject_if     => :all_blank
end
