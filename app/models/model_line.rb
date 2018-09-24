class ModelLine < ApplicationRecord
    belongs_to :company
    has_many :coaster_models
end
