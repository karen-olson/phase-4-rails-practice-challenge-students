class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: true
    validates :age, exclusion: {in: 0..17, message: "must be at least 18"}
end
