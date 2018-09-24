class UserPark < ApplicationRecord
    has_one :park

    before_save :check_count

    def check_count
        if self.visit_count
            self.has_visited = true
        else 
            #set it to false and make sure it isn't negative
            self.has_visited = false
            self.visit_count = 0
        end
    end
end
