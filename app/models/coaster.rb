class Coaster < ApplicationRecord
    include Scrapper
    belongs_to :park
    has_many :coaster_companies
    has_many :companies, :through => :coaster_companies 
    has_many :coaster_model_types
    has_many :coaster_models, :through => :coaster_model_types
end
