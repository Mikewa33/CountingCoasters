class CoasterModel < ApplicationRecord
    has_one :company
    has_one :model_line
    has_many :coaster_model_types
    has_many :coasters, :through => :coaster_model_types
end
