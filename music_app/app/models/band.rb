class Band < ApplicationRecord
    validates :name, presence: true, uniqueness: {case_sensitive: true}
end
