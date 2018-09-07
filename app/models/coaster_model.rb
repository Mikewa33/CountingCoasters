class CoasterModel < ApplicationRecord
    has_one :company
    has_one :model_line
end
