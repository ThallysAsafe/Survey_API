class Research < ApplicationRecord
  has_many :questions
  validates :title, presence: true

end
