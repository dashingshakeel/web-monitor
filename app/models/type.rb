class Type < ApplicationRecord
 has_one :service,:dependent => :destroy
end
