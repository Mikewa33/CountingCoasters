class Park < ApplicationRecord
    has_many :coasters
    has_many :user_parks

end
