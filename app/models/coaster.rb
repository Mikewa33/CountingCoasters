class Coaster < ApplicationRecord
    include Scrapper
    belongs_to :park
end
