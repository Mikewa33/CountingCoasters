class Company < ApplicationRecord
    has_many :model_lines
    has_many :coaster_companies
    has_many :coaster_models
    has_many :coaster_companies
    has_many :coasters, :through => :coaster_companies
end
